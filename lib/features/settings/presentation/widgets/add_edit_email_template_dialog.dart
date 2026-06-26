import 'dart:io' show File;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/email_template.dart';
import '../providers/email_templates_providers.dart';
import 'email_template_dialog_chrome.dart';
import 'email_template_dialog_layouts.dart';
import 'email_template_form_fields.dart';
import 'email_template_preview_panel.dart';
import 'email_template_tags_sidebar.dart';

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
          'pdf', 'doc', 'docx', 'xls', 'xlsx',
          'png', 'jpg', 'jpeg', 'gif',
        ],
        allowMultiple: true,
        withData: true,
      );
      if (result != null && mounted) {
        setState(() => _pendingFiles.addAll(result.files));
      }
    } catch (e) {
      if (mounted) {
        setState(() =>
            _errorMessage = 'Could not open file picker. Please try again.');
      }
    }
  }

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
        await ref.read(emailTemplatesProvider.notifier).updateTemplate(template);
        savedId = template.id;
      } else {
        final created =
            await ref.read(emailTemplatesProvider.notifier).add(template);
        savedId = created.id;
      }

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
            setState(() => _errorMessage =
                'Template saved but "${file.name}" failed to upload: '
                '${Failure.fromException(e).message}');
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

  Widget _buildFormContent() {
    final activeCategory =
        _isEditing ? widget.existing!.category : _selectedCategory;
    final fields = _isEditing
        ? EmailTemplateEditFields(
            category: activeCategory,
            subjectCtrl: _subjectCtrl,
            bodyCtrl: _bodyCtrl,
            showHtmlSource: _showHtmlSource,
            attachments: _attachments,
            pendingFiles: _pendingFiles,
            onToggleHtml: () =>
                setState(() => _showHtmlSource = !_showHtmlSource),
            onRemoveAttachment: _removeAttachment,
            onRemovePending: (f) => setState(() => _pendingFiles.remove(f)),
            onPickFiles: _pickFiles,
          )
        : EmailTemplateAddFields(
            nameCtrl: _nameCtrl,
            slugCtrl: _slugCtrl,
            subjectCtrl: _subjectCtrl,
            bodyCtrl: _bodyCtrl,
            selectedCategory: _selectedCategory,
            showHtmlSource: _showHtmlSource,
            pendingFiles: _pendingFiles,
            onCategoryChanged: (c) =>
                setState(() => _selectedCategory = c!),
            onSlugChanged: (_) =>
                setState(() => _slugManuallyEdited = true),
            onToggleHtml: () =>
                setState(() => _showHtmlSource = !_showHtmlSource),
            onRemovePending: (f) => setState(() => _pendingFiles.remove(f)),
            onPickFiles: _pickFiles,
          );

    if (_errorMessage == null) return fields;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        EmailTemplateErrorBanner(
          message: _errorMessage!,
          onDismiss: _clearError,
        ),
        const SizedBox(height: 12),
        fields,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.screenSize.width < 600;
    final isDark = context.theme.brightness == Brightness.dark;
    final borderColor =
        isDark ? AppColors.darkBorder : AppColors.lightBorder;

    final header = EmailTemplateDialogHeader(
      existing: widget.existing,
      onClose: () => Navigator.of(context).pop(),
    );
    final footer = EmailTemplateDialogFooter(
      onCancel: () => Navigator.of(context).pop(),
      onSubmit: _submit,
      isSaving: _isSaving,
    );
    final preview = EmailTemplateLivePreviewPanel(
      subject: _subjectCtrl.text,
      body: _bodyCtrl.text,
    );
    final tags = EmailTemplateTagsSidebar(
      category: _isEditing ? widget.existing!.category : _selectedCategory,
      existing: widget.existing,
      onTagTap: _insertTag,
    );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: isMobile
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: isMobile
          ? EmailTemplateMobileLayout(
              header: header,
              formKey: _formKey,
              formContent: _buildFormContent(),
              previewPanel: preview,
              tagsWidget: tags,
              footer: footer,
              screenHeight: context.screenSize.height,
            )
          : EmailTemplateDesktopLayout(
              header: header,
              formKey: _formKey,
              formContent: _buildFormContent(),
              previewPanel: preview,
              tagsWidget: tags,
              footer: footer,
              borderColor: borderColor,
            ),
    );
  }
}
