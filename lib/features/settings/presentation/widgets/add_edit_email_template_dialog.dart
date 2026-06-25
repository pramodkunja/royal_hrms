import 'dart:io' show File;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/email_template.dart';
import '../providers/email_templates_providers.dart';
import 'email_html_preview.dart';

// ---------------------------------------------------------------------------
// Toolbar action enum
// ---------------------------------------------------------------------------

enum _ToolbarAction {
  bold,
  italic,
  underline,
  strikethrough,
  unorderedList,
  orderedList,
  alignLeft,
  alignCenter,
  alignRight,
  insertLink,
  removeLink,
  insertImage,
  clearFormatting,
}

// ---------------------------------------------------------------------------
// Dialog entry point
// ---------------------------------------------------------------------------

class AddEditEmailTemplateDialog extends ConsumerStatefulWidget {
  const AddEditEmailTemplateDialog({super.key, this.existing});

  final EmailTemplate? existing;

  static Future<void> show(BuildContext context, {EmailTemplate? existing}) {
    return showDialog(
      context: context,
      builder: (_) => AddEditEmailTemplateDialog(existing: existing),
    );
  }

  @override
  ConsumerState<AddEditEmailTemplateDialog> createState() =>
      _AddEditEmailTemplateDialogState();
}

class _AddEditEmailTemplateDialogState
    extends ConsumerState<AddEditEmailTemplateDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _slugCtrl;
  late final TextEditingController _subjectCtrl;
  late final TextEditingController _bodyCtrl;
  late EmailTemplateCategory _selectedCategory;
  bool _showHtmlSource = false;
  bool _slugManuallyEdited = false;
  bool _isSaving = false;
  String? _errorMessage;
  late List<EmailTemplateAttachment> _attachments;
  final List<PlatformFile> _pendingFiles = [];

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final t = widget.existing;
    _nameCtrl = TextEditingController(text: t?.name ?? '');
    _slugCtrl = TextEditingController(text: t?.slug ?? '');
    _subjectCtrl = TextEditingController(text: t?.subject ?? '');
    _bodyCtrl = TextEditingController(text: t?.body ?? '');
    _selectedCategory = t?.category ?? EmailTemplateCategory.notification;
    _attachments = List<EmailTemplateAttachment>.from(t?.attachments ?? []);
    _nameCtrl.addListener(_onNameChanged);
    _subjectCtrl.addListener(_onFormChanged);
    _bodyCtrl.addListener(_onFormChanged);
    if (t != null) _slugManuallyEdited = true;
  }

  @override
  void dispose() {
    _nameCtrl.removeListener(_onNameChanged);
    _subjectCtrl.removeListener(_onFormChanged);
    _bodyCtrl.removeListener(_onFormChanged);
    _nameCtrl.dispose();
    _slugCtrl.dispose();
    _subjectCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    if (_slugManuallyEdited) return;
    final slug = _nameCtrl.text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
        .trim()
        .replaceAll(RegExp(r'\s+'), '_');
    _slugCtrl.text = slug;
  }

  void _onFormChanged() => setState(() {});

  void _clearError() {
    if (_errorMessage != null) setState(() => _errorMessage = null);
  }

  void _insertTag(String tag) {
    final text = _bodyCtrl.text;
    final sel = _bodyCtrl.selection;
    final pos =
        sel.isValid ? sel.baseOffset.clamp(0, text.length) : text.length;
    final newText = text.substring(0, pos) + tag + text.substring(pos);
    _bodyCtrl.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: pos + tag.length),
    );
  }

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'doc',
          'docx',
          'xls',
          'xlsx',
          'png',
          'jpg',
          'jpeg',
          'gif',
        ],
        allowMultiple: true,
        withData: true,
      );
      if (result != null && mounted) {
        setState(() => _pendingFiles.addAll(result.files));
      }
    } catch (e) {
      if (mounted) {
        setState(
          () => _errorMessage =
              'Could not open file picker. Please try again.',
        );
      }
    }
  }

  /// Returns file bytes — prefers in-memory bytes from [FilePicker],
  /// falls back to [dart:io] read when [withData] did not populate bytes.
  Future<Uint8List?> _fileBytes(PlatformFile file) async {
    if (file.bytes != null) return file.bytes;
    if (file.path != null) {
      try {
        return await File(file.path!).readAsBytes();
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<void> _removeAttachment(EmailTemplateAttachment attachment) async {
    if (!_isEditing) return;
    setState(() => _attachments.removeWhere((a) => a.id == attachment.id));
    try {
      await ref
          .read(emailTemplatesProvider.notifier)
          .removeAttachment(widget.existing!.id, attachment.id);
    } on AppException catch (e) {
      setState(() {
        _attachments.add(attachment);
        _errorMessage = Failure.fromException(e).message;
      });
    }
  }

  Future<void> _submit() async {
    _clearError();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSaving = true);
    try {
      final existing = widget.existing;
      final activeCategory =
          _isEditing ? existing!.category : _selectedCategory;

      final template = EmailTemplate(
        id: existing?.id ?? '',
        name: _isEditing ? existing!.name : _nameCtrl.text.trim(),
        slug: _isEditing ? existing!.slug : _slugCtrl.text.trim(),
        category: activeCategory,
        subject: _subjectCtrl.text.trim(),
        body: _bodyCtrl.text.trim(),
        description:
            _isEditing ? existing!.description : _subjectCtrl.text.trim(),
        isBuiltIn: existing?.isBuiltIn ?? false,
        isActive: existing?.isActive ?? true,
        availableVariables: existing?.availableVariables.isNotEmpty == true
            ? existing!.availableVariables
            : tagsForCategory(activeCategory),
        attachments: _attachments,
      );

      String savedId;
      if (_isEditing) {
        await ref
            .read(emailTemplatesProvider.notifier)
            .updateTemplate(template);
        savedId = template.id;
      } else {
        final created =
            await ref.read(emailTemplatesProvider.notifier).add(template);
        savedId = created.id;
      }

      // Upload any pending files after the template is saved
      for (final file in List<PlatformFile>.from(_pendingFiles)) {
        final bytes = await _fileBytes(file);
        if (bytes == null) continue;
        try {
          final attachment = await ref
              .read(emailTemplatesProvider.notifier)
              .uploadAttachment(savedId, file.name, bytes);
          if (mounted) setState(() => _attachments.add(attachment));
        } on AppException catch (e) {
          if (mounted) {
            setState(
              () => _errorMessage =
                  'Template saved but "${file.name}" failed to upload: '
                  '${Failure.fromException(e).message}',
            );
          }
        }
      }
      if (mounted) setState(() => _pendingFiles.clear());

      if (mounted) Navigator.of(context).pop();
    } on AppException catch (e) {
      if (mounted) {
        setState(() => _errorMessage = Failure.fromException(e).message);
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.screenSize.width < 600;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: isMobile
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: isMobile
          ? _buildMobileLayout(context)
          : _buildDesktopLayout(context),
    );
  }

  // ── Mobile layout ─────────────────────────────────────────────────────────

  Widget _buildMobileLayout(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.screenSize.height,
      child: Column(
        children: [
          _DialogHeader(
            existing: widget.existing,
            onClose: () => Navigator.of(context).pop(),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormColumn(context),
                    const SizedBox(height: 24),
                    _LivePreviewPanel(
                      subject: _subjectCtrl.text,
                      body: _bodyCtrl.text,
                    ),
                    const SizedBox(height: 24),
                    _AvailableTagsSidebar(
                      category: _isEditing
                          ? widget.existing!.category
                          : _selectedCategory,
                      existing: widget.existing,
                      onTagTap: _insertTag,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          _DialogFooter(
            onCancel: () => Navigator.of(context).pop(),
            onSubmit: _submit,
            isSaving: _isSaving,
          ),
        ],
      ),
    );
  }

  // ── Desktop layout: 3 columns ─────────────────────────────────────────────

  Widget _buildDesktopLayout(BuildContext context) {
    final borderColor = context.theme.brightness == Brightness.dark
        ? AppColors.darkBorder
        : AppColors.lightBorder;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1180, maxHeight: 780),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DialogHeader(
            existing: widget.existing,
            onClose: () => Navigator.of(context).pop(),
          ),
          const Divider(height: 1),
          Expanded(
            child: Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: form fields
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: _buildFormColumn(context),
                    ),
                  ),
                  VerticalDivider(width: 1, color: borderColor),
                  // Middle: live preview
                  Expanded(
                    flex: 5,
                    child: _LivePreviewPanel(
                      subject: _subjectCtrl.text,
                      body: _bodyCtrl.text,
                    ),
                  ),
                  VerticalDivider(width: 1, color: borderColor),
                  // Right: available tags
                  SizedBox(
                    width: 200,
                    child: _AvailableTagsSidebar(
                      category: _isEditing
                          ? widget.existing!.category
                          : _selectedCategory,
                      existing: widget.existing,
                      onTagTap: _insertTag,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          _DialogFooter(
            onCancel: () => Navigator.of(context).pop(),
            onSubmit: _submit,
            isSaving: _isSaving,
          ),
        ],
      ),
    );
  }

  // ── Form column content ───────────────────────────────────────────────────

  Widget _buildFormColumn(BuildContext context) {
    final fields = _isEditing
        ? _EditFields(
            category: widget.existing!.category,
            subjectCtrl: _subjectCtrl,
            bodyCtrl: _bodyCtrl,
            showHtmlSource: _showHtmlSource,
            attachments: _attachments,
            pendingFiles: _pendingFiles,
            onToggleHtml: () =>
                setState(() => _showHtmlSource = !_showHtmlSource),
            onRemoveAttachment: _removeAttachment,
            onRemovePending: (f) =>
                setState(() => _pendingFiles.remove(f)),
            onPickFiles: _pickFiles,
          )
        : _AddFields(
            nameCtrl: _nameCtrl,
            slugCtrl: _slugCtrl,
            subjectCtrl: _subjectCtrl,
            bodyCtrl: _bodyCtrl,
            selectedCategory: _selectedCategory,
            showHtmlSource: _showHtmlSource,
            pendingFiles: _pendingFiles,
            onCategoryChanged: (c) => setState(() => _selectedCategory = c!),
            onSlugChanged: (_) => setState(() => _slugManuallyEdited = true),
            onToggleHtml: () =>
                setState(() => _showHtmlSource = !_showHtmlSource),
            onRemovePending: (f) =>
                setState(() => _pendingFiles.remove(f)),
            onPickFiles: _pickFiles,
          );

    if (_errorMessage == null) return fields;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _ErrorBanner(message: _errorMessage!, onDismiss: _clearError),
        const SizedBox(height: 12),
        fields,
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Inline error banner
// ---------------------------------------------------------------------------

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message, required this.onDismiss});

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;
    final errorContainerColor = Theme.of(context).colorScheme.errorContainer;
    final onErrorContainerColor =
        Theme.of(context).colorScheme.onErrorContainer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: errorContainerColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: errorColor.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(Icons.error_outline, size: 18, color: errorColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: onErrorContainerColor,
                fontWeight: FontWeight.w500,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onDismiss,
            child: Icon(Icons.close, size: 16, color: errorColor),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Dialog header
// ---------------------------------------------------------------------------

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({required this.existing, required this.onClose});

  final EmailTemplate? existing;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final isEditing = existing != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 18, 16, 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: isEditing ? 'Edit — ' : 'Add Email Template',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    children: isEditing
                        ? [
                            TextSpan(
                              text: existing!.name,
                              style: TextStyle(
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ]
                        : null,
                  ),
                ),
                if (isEditing) ...[
                  const SizedBox(height: 2),
                  Text(
                    existing!.description,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: mutedColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close),
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Edit-only form: Category (readonly) + Subject + Body + Attachments
// ---------------------------------------------------------------------------

class _EditFields extends StatelessWidget {
  const _EditFields({
    required this.category,
    required this.subjectCtrl,
    required this.bodyCtrl,
    required this.showHtmlSource,
    required this.attachments,
    required this.pendingFiles,
    required this.onToggleHtml,
    required this.onRemoveAttachment,
    required this.onRemovePending,
    required this.onPickFiles,
  });

  final EmailTemplateCategory category;
  final TextEditingController subjectCtrl;
  final TextEditingController bodyCtrl;
  final bool showHtmlSource;
  final List<EmailTemplateAttachment> attachments;
  final List<PlatformFile> pendingFiles;
  final VoidCallback onToggleHtml;
  final ValueChanged<EmailTemplateAttachment> onRemoveAttachment;
  final ValueChanged<PlatformFile> onRemovePending;
  final VoidCallback onPickFiles;

  String _categoryLabel(EmailTemplateCategory c) {
    return switch (c) {
      EmailTemplateCategory.document => 'document',
      EmailTemplateCategory.notification => 'notification',
      EmailTemplateCategory.reminder => 'reminder',
      EmailTemplateCategory.wish => 'wish',
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final fillColor =
        isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category (readonly)
        _FieldLabel(label: 'Category', required: true),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _categoryLabel(category),
                  style: context.textTheme.bodyMedium,
                ),
              ),
              Icon(Icons.lock_outline, size: 15, color: mutedColor),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Category cannot be changed after creation.',
          style: context.textTheme.bodySmall?.copyWith(color: mutedColor),
        ),
        const SizedBox(height: 18),
        // Subject
        _FieldLabel(label: 'Subject', required: true),
        const SizedBox(height: 8),
        TextFormField(
          controller: subjectCtrl,
          decoration: const InputDecoration(hintText: 'Email subject line...'),
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Subject is required' : null,
        ),
        const SizedBox(height: 18),
        // Body
        Row(
          children: [
            Expanded(child: _FieldLabel(label: 'Body', required: true)),
            _HtmlToggleButton(
              showHtmlSource: showHtmlSource,
              onToggle: onToggleHtml,
            ),
          ],
        ),
        const SizedBox(height: 8),
        _BodyEditor(controller: bodyCtrl, showHtmlSource: showHtmlSource),
        const SizedBox(height: 16),
        // Attachments row
        _AttachFilesRow(
          attachments: attachments,
          pendingFiles: pendingFiles,
          onRemoveUploaded: onRemoveAttachment,
          onRemovePending: onRemovePending,
          onPickFiles: onPickFiles,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Add-only form: Display Name + Slug + Category + Subject + Body
// ---------------------------------------------------------------------------

class _AddFields extends StatelessWidget {
  const _AddFields({
    required this.nameCtrl,
    required this.slugCtrl,
    required this.subjectCtrl,
    required this.bodyCtrl,
    required this.selectedCategory,
    required this.showHtmlSource,
    required this.pendingFiles,
    required this.onCategoryChanged,
    required this.onSlugChanged,
    required this.onToggleHtml,
    required this.onRemovePending,
    required this.onPickFiles,
  });

  final TextEditingController nameCtrl;
  final TextEditingController slugCtrl;
  final TextEditingController subjectCtrl;
  final TextEditingController bodyCtrl;
  final EmailTemplateCategory selectedCategory;
  final bool showHtmlSource;
  final List<PlatformFile> pendingFiles;
  final ValueChanged<EmailTemplateCategory?> onCategoryChanged;
  final ValueChanged<String> onSlugChanged;
  final VoidCallback onToggleHtml;
  final ValueChanged<PlatformFile> onRemovePending;
  final VoidCallback onPickFiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: 'Display Name', required: true),
        const SizedBox(height: 8),
        TextFormField(
          controller: nameCtrl,
          decoration: const InputDecoration(hintText: 'e.g. Birthday Wish'),
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Name is required' : null,
        ),
        const SizedBox(height: 18),
        _FieldLabel(label: 'Identifier (slug)'),
        const SizedBox(height: 8),
        TextFormField(
          controller: slugCtrl,
          onChanged: onSlugChanged,
          decoration: const InputDecoration(
            hintText: 'e.g. birthday_wish',
            prefixText: 'slug: ',
          ),
        ),
        const SizedBox(height: 18),
        _FieldLabel(label: 'Category', required: true),
        const SizedBox(height: 8),
        // ignore: deprecated_member_use
        DropdownButtonFormField<EmailTemplateCategory>(
          value: selectedCategory, // ignore: deprecated_member_use
          decoration: const InputDecoration(),
          items: const [
            DropdownMenuItem(
              value: EmailTemplateCategory.document,
              child: Text('Document'),
            ),
            DropdownMenuItem(
              value: EmailTemplateCategory.notification,
              child: Text('Notification'),
            ),
            DropdownMenuItem(
              value: EmailTemplateCategory.reminder,
              child: Text('Reminder'),
            ),
            DropdownMenuItem(
              value: EmailTemplateCategory.wish,
              child: Text('Wish'),
            ),
          ],
          onChanged: onCategoryChanged,
        ),
        const SizedBox(height: 18),
        _FieldLabel(label: 'Subject', required: true),
        const SizedBox(height: 8),
        TextFormField(
          controller: subjectCtrl,
          decoration: const InputDecoration(hintText: 'Email subject line...'),
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Subject is required' : null,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(child: _FieldLabel(label: 'Body', required: true)),
            _HtmlToggleButton(
              showHtmlSource: showHtmlSource,
              onToggle: onToggleHtml,
            ),
          ],
        ),
        const SizedBox(height: 8),
        _BodyEditor(controller: bodyCtrl, showHtmlSource: showHtmlSource),
        const SizedBox(height: 16),
        _AttachFilesRow(
          attachments: const [],
          pendingFiles: pendingFiles,
          onRemoveUploaded: (_) {},
          onRemovePending: onRemovePending,
          onPickFiles: onPickFiles,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Live Preview panel (middle column)
// ---------------------------------------------------------------------------

class _LivePreviewPanel extends StatelessWidget {
  const _LivePreviewPanel({required this.subject, required this.body});

  final String subject;
  final String body;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final bgColor = isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final bodyBase = context.textTheme.bodySmall;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LIVE PREVIEW',
            style: context.textTheme.labelSmall?.copyWith(
              color: mutedColor,
              letterSpacing: 0.9,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          _PreviewSection(
            label: 'SUBJECT',
            borderColor: borderColor,
            bgColor: bgColor,
            mutedColor: mutedColor,
            child: subject.isEmpty
                ? Text(
                    'No subject yet…',
                    style: bodyBase?.copyWith(
                      color: mutedColor,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : EmailHtmlPreview(html: subject, style: bodyBase),
          ),
          const SizedBox(height: 14),
          _PreviewSection(
            label: 'BODY',
            borderColor: borderColor,
            bgColor: bgColor,
            mutedColor: mutedColor,
            minHeight: 180,
            child: body.isEmpty
                ? Text(
                    'No body content yet…',
                    style: bodyBase?.copyWith(
                      color: mutedColor,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : EmailHtmlPreview(html: body, style: bodyBase),
          ),
        ],
      ),
    );
  }
}

class _PreviewSection extends StatelessWidget {
  const _PreviewSection({
    required this.label,
    required this.borderColor,
    required this.bgColor,
    required this.mutedColor,
    required this.child,
    this.minHeight = 0,
  });

  final String label;
  final Color borderColor;
  final Color bgColor;
  final Color mutedColor;
  final Widget child;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: mutedColor,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: minHeight),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
          ),
          child: child,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Available Tags sidebar (right column)
// ---------------------------------------------------------------------------

class _AvailableTagsSidebar extends StatelessWidget {
  const _AvailableTagsSidebar({
    required this.category,
    required this.existing,
    required this.onTagTap,
  });

  final EmailTemplateCategory category;
  final EmailTemplate? existing;
  final ValueChanged<String> onTagTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final chipBg =
        isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;

    final tags = (existing?.availableVariables.isNotEmpty ?? false)
        ? existing!.availableVariables
        : tagsForCategory(category);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AVAILABLE TAGS',
            style: context.textTheme.labelSmall?.copyWith(
              color: mutedColor,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          ...tags.map(
            (tag) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _TagChip(
                tag: tag,
                background: chipBg,
                onTap: () => onTagTap(tag),
              ),
            ),
          ),
          if (existing != null) ...[
            const SizedBox(height: 20),
            _LastUpdatedSection(template: existing!),
          ],
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.tag,
    required this.background,
    required this.onTap,
  });

  final String tag;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          tag,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _LastUpdatedSection extends StatelessWidget {
  const _LastUpdatedSection({required this.template});

  final EmailTemplate template;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final dateStr = template.lastUpdatedAt != null
        ? DateFormat('d MMM yyyy, h:mm a').format(template.lastUpdatedAt!)
        : '—';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last updated',
          style: context.textTheme.labelSmall?.copyWith(color: mutedColor),
        ),
        const SizedBox(height: 2),
        Text(
          dateStr,
          style: context.textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (template.isBuiltIn) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.verified_outlined,
                size: 14,
                color: AppColors.emailCategoryNotification,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  'Built-in template',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.emailCategoryNotification,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Attach files row: pick button + uploaded chips + pending chips
// ---------------------------------------------------------------------------

class _AttachFilesRow extends StatelessWidget {
  const _AttachFilesRow({
    required this.attachments,
    required this.pendingFiles,
    required this.onRemoveUploaded,
    required this.onRemovePending,
    required this.onPickFiles,
  });

  final List<EmailTemplateAttachment> attachments;
  final List<PlatformFile> pendingFiles;
  final ValueChanged<EmailTemplateAttachment> onRemoveUploaded;
  final ValueChanged<PlatformFile> onRemovePending;
  final VoidCallback onPickFiles;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final chipBg = isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;
    final totalCount = attachments.length + pendingFiles.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Pick files button
            OutlinedButton.icon(
              onPressed: onPickFiles,
              icon: Icon(Icons.attach_file, size: 15, color: mutedColor),
              label: Text(
                'Attach files',
                style: TextStyle(color: mutedColor),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 38),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 0,
                ),
                side: BorderSide(color: borderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            if (totalCount > 0) ...[
              const SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Uploaded attachments (from API)
                      ...attachments.map(
                        (a) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _AttachmentChip(
                            label: '${a.filename} ${a.displaySize}',
                            background: chipBg,
                            borderColor: borderColor,
                            mutedColor: mutedColor,
                            onRemove: () => onRemoveUploaded(a),
                          ),
                        ),
                      ),
                      // Pending files (picked but not yet uploaded)
                      ...pendingFiles.map(
                        (f) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _AttachmentChip(
                            label: f.name,
                            background: AppColors.warning.withValues(alpha: 0.12),
                            borderColor: AppColors.warning.withValues(alpha: 0.45),
                            mutedColor: mutedColor,
                            onRemove: () => onRemovePending(f),
                            isPending: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$totalCount ${totalCount == 1 ? 'file' : 'files'}',
                style: context.textTheme.bodySmall?.copyWith(
                  color: mutedColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ] else ...[
              const SizedBox(width: 12),
              Text(
                'PDF, Word, Excel, images',
                style: context.textTheme.bodySmall?.copyWith(
                  color: mutedColor.withValues(alpha: 0.6),
                ),
              ),
            ],
          ],
        ),
        if (pendingFiles.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            'Pending files will be uploaded when you save.',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.warning,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }
}

class _AttachmentChip extends StatelessWidget {
  const _AttachmentChip({
    required this.label,
    required this.background,
    required this.borderColor,
    required this.mutedColor,
    required this.onRemove,
    this.isPending = false,
  });

  final String label;
  final Color background;
  final Color borderColor;
  final Color mutedColor;
  final VoidCallback onRemove;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPending ? Icons.upload_outlined : Icons.insert_drive_file_outlined,
            size: 13,
            color: isPending ? AppColors.warning : mutedColor,
          ),
          const SizedBox(width: 5),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 120),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isPending ? AppColors.warning : mutedColor,
                fontSize: 11,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 13,
              color: isPending ? AppColors.warning : mutedColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared sub-widgets
// ---------------------------------------------------------------------------

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, this.required = false});

  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    return RichText(
      text: TextSpan(
        text: label,
        style: context.textTheme.labelMedium?.copyWith(
          color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
          fontWeight: FontWeight.w500,
        ),
        children: required
            ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ]
            : null,
      ),
    );
  }
}

class _HtmlToggleButton extends StatelessWidget {
  const _HtmlToggleButton({
    required this.showHtmlSource,
    required this.onToggle,
  });

  final bool showHtmlSource;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onToggle,
      icon: const Icon(Icons.code, size: 14),
      label: Text(
        showHtmlSource ? 'Visual editor' : 'HTML source',
        style: const TextStyle(fontSize: 12),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Body editor — wraps the TextField with the functional toolbar
// ---------------------------------------------------------------------------

class _BodyEditor extends StatelessWidget {
  const _BodyEditor({
    required this.controller,
    required this.showHtmlSource,
  });

  final TextEditingController controller;
  final bool showHtmlSource;

  // ── HTML manipulation helpers ────────────────────────────────────────────

  void _wrapSelection(String openTag, String closeTag) {
    final sel = controller.selection;
    final text = controller.text;
    final start = sel.isValid ? sel.start : text.length;
    final end = sel.isValid ? sel.end : text.length;

    if (start == end) {
      // No selection — insert tags at cursor, place caret between them
      final newText =
          text.substring(0, start) + openTag + closeTag + text.substring(start);
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: start + openTag.length),
      );
    } else {
      // Wrap selected text
      final selected = text.substring(start, end);
      final newText =
          text.substring(0, start) + openTag + selected + closeTag + text.substring(end);
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: start + openTag.length + selected.length + closeTag.length,
        ),
      );
    }
  }

  void _insertListBlock(String tag) {
    final sel = controller.selection;
    final text = controller.text;

    if (sel.isValid && sel.start != sel.end) {
      final selected = text.substring(sel.start, sel.end);
      final items = selected
          .split('\n')
          .where((l) => l.isNotEmpty)
          .map((l) => '  <li>$l</li>')
          .join('\n');
      final block = '<$tag>\n$items\n</$tag>';
      final newText =
          text.substring(0, sel.start) + block + text.substring(sel.end);
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: sel.start + block.length),
      );
    } else {
      final block = '<$tag>\n  <li></li>\n</$tag>';
      final pos = sel.isValid ? sel.baseOffset.clamp(0, text.length) : text.length;
      final newText = text.substring(0, pos) + block + text.substring(pos);
      // Place caret inside the <li>
      final caretPos = pos + '<$tag>\n  <li>'.length;
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: caretPos),
      );
    }
  }

  void _wrapWithAlign(String alignment) {
    _wrapSelection('<p style="text-align: $alignment;">', '</p>');
  }

  void _removeLinks() {
    final sel = controller.selection;
    final text = controller.text;

    String strip(String s) => s
        .replaceAll(RegExp(r'<a\s[^>]*>', caseSensitive: false), '')
        .replaceAll(RegExp(r'</a>', caseSensitive: false), '');

    if (sel.isValid && sel.start != sel.end) {
      final clean = strip(text.substring(sel.start, sel.end));
      final newText = text.substring(0, sel.start) + clean + text.substring(sel.end);
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: sel.start + clean.length),
      );
    } else {
      controller.value = TextEditingValue(
        text: strip(text),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  void _clearFormatting() {
    final sel = controller.selection;
    final text = controller.text;
    String strip(String s) => s.replaceAll(RegExp(r'<[^>]+>'), '');

    if (sel.isValid && sel.start != sel.end) {
      final clean = strip(text.substring(sel.start, sel.end));
      final newText = text.substring(0, sel.start) + clean + text.substring(sel.end);
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: sel.start + clean.length),
      );
    } else {
      controller.value = TextEditingValue(
        text: strip(text),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  // ── Dialog-backed actions ────────────────────────────────────────────────

  Future<void> _showInsertLinkDialog(BuildContext context) async {
    // Capture selection NOW — the TextField loses focus when the dialog opens
    final savedSel = controller.selection;
    final selectedText = (savedSel.isValid && savedSel.start != savedSel.end)
        ? controller.text.substring(savedSel.start, savedSel.end)
        : '';

    final result = await showDialog<(String, String)?>(
      context: context,
      builder: (_) => _InsertLinkDialog(prefillText: selectedText),
    );
    if (!context.mounted || result == null) return;

    final (url, linkText) = result;
    final tag = '<a href="$url">$linkText</a>';
    final text = controller.text;
    final pos =
        savedSel.isValid ? savedSel.start.clamp(0, text.length) : text.length;
    final end = (savedSel.isValid && savedSel.start != savedSel.end)
        ? savedSel.end.clamp(0, text.length)
        : pos;
    controller.value = TextEditingValue(
      text: text.substring(0, pos) + tag + text.substring(end),
      selection: TextSelection.collapsed(offset: pos + tag.length),
    );
  }

  Future<void> _showInsertImageDialog(BuildContext context) async {
    // Capture cursor position NOW — the TextField loses focus when dialog opens
    final savedSel = controller.selection;

    final result = await showDialog<(String, String)?>(
      context: context,
      builder: (_) => const _InsertImageDialog(),
    );
    if (!context.mounted || result == null) return;

    final (url, alt) = result;
    final tag = '<img src="$url" alt="$alt"/>';
    final text = controller.text;
    final pos = savedSel.isValid
        ? savedSel.baseOffset.clamp(0, text.length)
        : text.length;
    controller.value = TextEditingValue(
      text: text.substring(0, pos) + tag + text.substring(pos),
      selection: TextSelection.collapsed(offset: pos + tag.length),
    );
  }

  // ── Dispatch from toolbar ────────────────────────────────────────────────

  void _handleAction(BuildContext context, _ToolbarAction action) {
    switch (action) {
      case _ToolbarAction.bold:
        _wrapSelection('<strong>', '</strong>');
      case _ToolbarAction.italic:
        _wrapSelection('<em>', '</em>');
      case _ToolbarAction.underline:
        _wrapSelection('<u>', '</u>');
      case _ToolbarAction.strikethrough:
        _wrapSelection('<s>', '</s>');
      case _ToolbarAction.unorderedList:
        _insertListBlock('ul');
      case _ToolbarAction.orderedList:
        _insertListBlock('ol');
      case _ToolbarAction.alignLeft:
        _wrapWithAlign('left');
      case _ToolbarAction.alignCenter:
        _wrapWithAlign('center');
      case _ToolbarAction.alignRight:
        _wrapWithAlign('right');
      case _ToolbarAction.insertLink:
        _showInsertLinkDialog(context);
      case _ToolbarAction.removeLink:
        _removeLinks();
      case _ToolbarAction.insertImage:
        _showInsertImageDialog(context);
      case _ToolbarAction.clearFormatting:
        _clearFormatting();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final fillColor =
        isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
        color: fillColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!showHtmlSource)
            _EditorToolbar(
              borderColor: borderColor,
              onAction: (action) => _handleAction(context, action),
            ),
          TextField(
            controller: controller,
            maxLines: 9,
            minLines: 7,
            style: showHtmlSource
                ? const TextStyle(fontFamily: 'monospace', fontSize: 12)
                : null,
            decoration: InputDecoration(
              hintText: showHtmlSource
                  ? '<p>Enter HTML content...</p>'
                  : 'Type your message here...',
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Editor toolbar — functional buttons mapped to _ToolbarAction
// ---------------------------------------------------------------------------

class _EditorToolbar extends StatelessWidget {
  const _EditorToolbar({
    required this.borderColor,
    required this.onAction,
  });

  final Color borderColor;
  final void Function(_ToolbarAction) onAction;

  static const _tools = <(IconData, String, _ToolbarAction)?>[
    (Icons.format_bold, 'Bold', _ToolbarAction.bold),
    (Icons.format_italic, 'Italic', _ToolbarAction.italic),
    (Icons.format_underline, 'Underline', _ToolbarAction.underline),
    (Icons.format_strikethrough, 'Strikethrough', _ToolbarAction.strikethrough),
    null,
    (Icons.format_list_bulleted, 'Unordered list', _ToolbarAction.unorderedList),
    (Icons.format_list_numbered, 'Ordered list', _ToolbarAction.orderedList),
    null,
    (Icons.format_align_left, 'Align left', _ToolbarAction.alignLeft),
    (Icons.format_align_center, 'Align center', _ToolbarAction.alignCenter),
    (Icons.format_align_right, 'Align right', _ToolbarAction.alignRight),
    null,
    (Icons.link, 'Insert link', _ToolbarAction.insertLink),
    (Icons.link_off, 'Remove link', _ToolbarAction.removeLink),
    (Icons.image_outlined, 'Insert image', _ToolbarAction.insertImage),
    null,
    (Icons.format_clear, 'Clear formatting', _ToolbarAction.clearFormatting),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final iconColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: Wrap(
        spacing: 2,
        runSpacing: 2,
        children: _tools.map((t) {
          if (t == null) {
            return Container(
              width: 1,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              color: borderColor,
            );
          }
          final (icon, tooltip, action) = t;
          return Tooltip(
            message: tooltip,
            child: InkWell(
              onTap: () => onAction(action),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Insert Link dialog
// ---------------------------------------------------------------------------

class _InsertLinkDialog extends StatefulWidget {
  const _InsertLinkDialog({this.prefillText = ''});

  final String prefillText;

  @override
  State<_InsertLinkDialog> createState() => _InsertLinkDialogState();
}

class _InsertLinkDialogState extends State<_InsertLinkDialog> {
  late final TextEditingController _urlCtrl;
  late final TextEditingController _textCtrl;

  @override
  void initState() {
    super.initState();
    _urlCtrl = TextEditingController();
    _textCtrl = TextEditingController(text: widget.prefillText);
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Insert Link'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _urlCtrl,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'URL',
              hintText: 'https://example.com',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _textCtrl,
            decoration: const InputDecoration(
              labelText: 'Display text',
              hintText: 'Link text (defaults to URL)',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final url = _urlCtrl.text.trim();
            if (url.isEmpty) return;
            final text =
                _textCtrl.text.trim().isEmpty ? url : _textCtrl.text.trim();
            Navigator.of(context).pop((url, text));
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Insert'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Insert Image dialog
// ---------------------------------------------------------------------------

class _InsertImageDialog extends StatefulWidget {
  const _InsertImageDialog();

  @override
  State<_InsertImageDialog> createState() => _InsertImageDialogState();
}

class _InsertImageDialogState extends State<_InsertImageDialog> {
  late final TextEditingController _urlCtrl;
  late final TextEditingController _altCtrl;

  @override
  void initState() {
    super.initState();
    _urlCtrl = TextEditingController();
    _altCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    _altCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Insert Image'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _urlCtrl,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Image URL',
              hintText: 'https://example.com/image.png',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _altCtrl,
            decoration: const InputDecoration(
              labelText: 'Alt text (optional)',
              hintText: 'Describe the image',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final url = _urlCtrl.text.trim();
            if (url.isEmpty) return;
            Navigator.of(context).pop((url, _altCtrl.text.trim()));
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Insert'),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Dialog footer
// ---------------------------------------------------------------------------

class _DialogFooter extends StatelessWidget {
  const _DialogFooter({
    required this.onCancel,
    required this.onSubmit,
    this.isSaving = false,
  });

  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: isSaving ? null : onCancel,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(0, 44),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            ),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: isSaving ? null : onSubmit,
            icon: isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.save_outlined, size: 16),
            label: const Text('Save Template'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, 44),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            ),
          ),
        ],
      ),
    );
  }
}
