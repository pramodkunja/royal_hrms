import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'email_template_editor_widgets.dart';
import 'email_template_toolbar_action.dart';

class EmailTemplateBodyEditor extends StatelessWidget {
  const EmailTemplateBodyEditor({
    super.key,
    required this.controller,
    required this.showHtmlSource,
  });

  final TextEditingController controller;
  final bool showHtmlSource;

  void _wrapSelection(String openTag, String closeTag) {
    final sel = controller.selection;
    final text = controller.text;
    final start = sel.isValid ? sel.start : text.length;
    final end = sel.isValid ? sel.end : text.length;
    if (start == end) {
      final newText =
          text.substring(0, start) + openTag + closeTag + text.substring(start);
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: start + openTag.length),
      );
    } else {
      final selected = text.substring(start, end);
      final newText = text.substring(0, start) +
          openTag +
          selected +
          closeTag +
          text.substring(end);
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
      final pos =
          sel.isValid ? sel.baseOffset.clamp(0, text.length) : text.length;
      final newText = text.substring(0, pos) + block + text.substring(pos);
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: pos + '<$tag>\n  <li>'.length,
        ),
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
      final newText =
          text.substring(0, sel.start) + clean + text.substring(sel.end);
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
      final newText =
          text.substring(0, sel.start) + clean + text.substring(sel.end);
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

  Future<void> _showInsertLinkDialog(BuildContext context) async {
    final savedSel = controller.selection;
    final selectedText = (savedSel.isValid && savedSel.start != savedSel.end)
        ? controller.text.substring(savedSel.start, savedSel.end)
        : '';
    final result = await showDialog<(String, String)?>(
      context: context,
      builder: (_) =>
          EmailTemplateInsertLinkDialog(prefillText: selectedText),
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
    final savedSel = controller.selection;
    final result = await showDialog<(String, String)?>(
      context: context,
      builder: (_) => const EmailTemplateInsertImageDialog(),
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

  void _handleAction(BuildContext context, EmailTemplateToolbarAction action) {
    switch (action) {
      case EmailTemplateToolbarAction.bold:
        _wrapSelection('<strong>', '</strong>');
      case EmailTemplateToolbarAction.italic:
        _wrapSelection('<em>', '</em>');
      case EmailTemplateToolbarAction.underline:
        _wrapSelection('<u>', '</u>');
      case EmailTemplateToolbarAction.strikethrough:
        _wrapSelection('<s>', '</s>');
      case EmailTemplateToolbarAction.unorderedList:
        _insertListBlock('ul');
      case EmailTemplateToolbarAction.orderedList:
        _insertListBlock('ol');
      case EmailTemplateToolbarAction.alignLeft:
        _wrapWithAlign('left');
      case EmailTemplateToolbarAction.alignCenter:
        _wrapWithAlign('center');
      case EmailTemplateToolbarAction.alignRight:
        _wrapWithAlign('right');
      case EmailTemplateToolbarAction.insertLink:
        _showInsertLinkDialog(context);
      case EmailTemplateToolbarAction.removeLink:
        _removeLinks();
      case EmailTemplateToolbarAction.insertImage:
        _showInsertImageDialog(context);
      case EmailTemplateToolbarAction.clearFormatting:
        _clearFormatting();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
            EmailTemplateEditorToolbar(
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
