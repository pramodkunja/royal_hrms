import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'email_template_toolbar_action.dart';

class EmailTemplateEditorToolbar extends StatelessWidget {
  const EmailTemplateEditorToolbar({
    super.key,
    required this.borderColor,
    required this.onAction,
  });

  final Color borderColor;
  final void Function(EmailTemplateToolbarAction) onAction;

  static const _tools =
      <(IconData, String, EmailTemplateToolbarAction)?>[
    (Icons.format_bold, 'Bold', EmailTemplateToolbarAction.bold),
    (Icons.format_italic, 'Italic', EmailTemplateToolbarAction.italic),
    (
      Icons.format_underline,
      'Underline',
      EmailTemplateToolbarAction.underline
    ),
    (
      Icons.format_strikethrough,
      'Strikethrough',
      EmailTemplateToolbarAction.strikethrough
    ),
    null,
    (
      Icons.format_list_bulleted,
      'Unordered list',
      EmailTemplateToolbarAction.unorderedList
    ),
    (
      Icons.format_list_numbered,
      'Ordered list',
      EmailTemplateToolbarAction.orderedList
    ),
    null,
    (
      Icons.format_align_left,
      'Align left',
      EmailTemplateToolbarAction.alignLeft
    ),
    (
      Icons.format_align_center,
      'Align center',
      EmailTemplateToolbarAction.alignCenter
    ),
    (
      Icons.format_align_right,
      'Align right',
      EmailTemplateToolbarAction.alignRight
    ),
    null,
    (Icons.link, 'Insert link', EmailTemplateToolbarAction.insertLink),
    (Icons.link_off, 'Remove link', EmailTemplateToolbarAction.removeLink),
    (
      Icons.image_outlined,
      'Insert image',
      EmailTemplateToolbarAction.insertImage
    ),
    null,
    (
      Icons.format_clear,
      'Clear formatting',
      EmailTemplateToolbarAction.clearFormatting
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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

class EmailTemplateInsertLinkDialog extends StatefulWidget {
  const EmailTemplateInsertLinkDialog({super.key, this.prefillText = ''});

  final String prefillText;

  @override
  State<EmailTemplateInsertLinkDialog> createState() =>
      _InsertLinkDialogState();
}

class _InsertLinkDialogState extends State<EmailTemplateInsertLinkDialog> {
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

class EmailTemplateInsertImageDialog extends StatefulWidget {
  const EmailTemplateInsertImageDialog({super.key});

  @override
  State<EmailTemplateInsertImageDialog> createState() =>
      _InsertImageDialogState();
}

class _InsertImageDialogState
    extends State<EmailTemplateInsertImageDialog> {
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
