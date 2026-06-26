import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/email_template.dart';
import 'email_template_attach_row.dart';
import 'email_template_body_editor.dart';
import 'email_template_dialog_chrome.dart';

class EmailTemplateEditFields extends StatelessWidget {
  const EmailTemplateEditFields({
    super.key,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark ? const Color(0xFF3A3A3A) : const Color(0xFFE0E0E0);
    final mutedColor =
        isDark ? const Color(0xFF9E9E9E) : const Color(0xFF757575);
    final fillColor =
        isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EmailTemplateFieldLabel(label: 'Category', required: true),
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
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Icon(Icons.lock_outline, size: 15, color: mutedColor),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Category cannot be changed after creation.',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: mutedColor),
        ),
        const SizedBox(height: 18),
        const EmailTemplateFieldLabel(label: 'Subject', required: true),
        const SizedBox(height: 8),
        TextFormField(
          controller: subjectCtrl,
          decoration:
              const InputDecoration(hintText: 'Email subject line...'),
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Subject is required' : null,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Expanded(
              child: EmailTemplateFieldLabel(label: 'Body', required: true),
            ),
            EmailTemplateHtmlToggleButton(
              showHtmlSource: showHtmlSource,
              onToggle: onToggleHtml,
            ),
          ],
        ),
        const SizedBox(height: 8),
        EmailTemplateBodyEditor(
          controller: bodyCtrl,
          showHtmlSource: showHtmlSource,
        ),
        const SizedBox(height: 16),
        EmailTemplateAttachFilesRow(
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

class EmailTemplateAddFields extends StatelessWidget {
  const EmailTemplateAddFields({
    super.key,
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
        const EmailTemplateFieldLabel(label: 'Display Name', required: true),
        const SizedBox(height: 8),
        TextFormField(
          controller: nameCtrl,
          decoration:
              const InputDecoration(hintText: 'e.g. Birthday Wish'),
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Name is required' : null,
        ),
        const SizedBox(height: 18),
        const EmailTemplateFieldLabel(label: 'Identifier (slug)'),
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
        const EmailTemplateFieldLabel(label: 'Category', required: true),
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
        const EmailTemplateFieldLabel(label: 'Subject', required: true),
        const SizedBox(height: 8),
        TextFormField(
          controller: subjectCtrl,
          decoration:
              const InputDecoration(hintText: 'Email subject line...'),
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Subject is required' : null,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Expanded(
              child: EmailTemplateFieldLabel(label: 'Body', required: true),
            ),
            EmailTemplateHtmlToggleButton(
              showHtmlSource: showHtmlSource,
              onToggle: onToggleHtml,
            ),
          ],
        ),
        const SizedBox(height: 8),
        EmailTemplateBodyEditor(
          controller: bodyCtrl,
          showHtmlSource: showHtmlSource,
        ),
        const SizedBox(height: 16),
        EmailTemplateAttachFilesRow(
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
