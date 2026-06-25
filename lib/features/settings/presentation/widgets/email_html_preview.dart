import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';

/// Renders an HTML email body string as formatted Flutter [RichText].
///
/// Supported tags: strong/b, em/i, u, s/del/strike, a (link colour),
/// br, p/div (block break), li (bullet + break), img (icon + alt).
/// Also wraps {VARIABLE} placeholders in an amber badge.
class EmailHtmlPreview extends StatelessWidget {
  const EmailHtmlPreview({
    super.key,
    required this.html,
    this.style,
    this.highlightVars = true,
  });

  final String html;
  final TextStyle? style;
  final bool highlightVars;

  static final _varRe = RegExp(r'\{[A-Z][A-Z0-9_]*\}');
  static final _tokenRe = RegExp(r'<[^>]+>|[^<]+', dotAll: true);

  List<InlineSpan> _spans(BuildContext context) {
    final base = style ?? context.textTheme.bodyMedium;
    final linkColor = context.colorScheme.primary;

    final out = <InlineSpan>[];
    var bold = false;
    var italic = false;
    var underline = false;
    var strike = false;
    var link = false;

    for (final m in _tokenRe.allMatches(html)) {
      final tok = m.group(0)!;
      if (tok.isEmpty) continue;

      if (tok.startsWith('<')) {
        // ── HTML tag ────────────────────────────────────────────────────────
        final inner = tok.substring(1, tok.length - 1).trimLeft();
        final closing = inner.startsWith('/');
        final rawName =
            (closing ? inner.substring(1) : inner).split(RegExp(r'[\s/]'))[0];
        final name = rawName.toLowerCase();

        if (name == 'strong' || name == 'b') {
          bold = !closing;
        } else if (name == 'em' || name == 'i') {
          italic = !closing;
        } else if (name == 'u') {
          underline = !closing;
        } else if (name == 's' || name == 'del' || name == 'strike') {
          strike = !closing;
        } else if (name == 'a') {
          link = !closing;
        } else if (name == 'br') {
          out.add(const TextSpan(text: '\n'));
        } else if (name == 'p' || name == 'div') {
          if (closing) out.add(const TextSpan(text: '\n'));
        } else if (name == 'li') {
          if (!closing) {
            out.add(const TextSpan(text: '• '));
          } else {
            out.add(const TextSpan(text: '\n'));
          }
        } else if (name == 'img') {
          final altM = RegExp(r'\balt="([^"]*)"', caseSensitive: false)
              .firstMatch(inner);
          final alt = altM?.group(1) ?? '';
          out.add(
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image_outlined, size: 14, color: linkColor),
                    if (alt.isNotEmpty) ...[
                      const SizedBox(width: 2),
                      Text(
                        '[$alt]',
                        style: (base ?? const TextStyle()).copyWith(
                          color: linkColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }
      } else {
        // ── Text node ────────────────────────────────────────────────────────
        final decos = <TextDecoration>[
          if (underline) TextDecoration.underline,
          if (strike) TextDecoration.lineThrough,
        ];
        final ts = (base ?? const TextStyle()).copyWith(
          fontWeight: bold ? FontWeight.bold : null,
          fontStyle: italic ? FontStyle.italic : null,
          decoration: decos.isEmpty ? null : TextDecoration.combine(decos),
          color: link ? linkColor : null,
        );

        if (!highlightVars) {
          out.add(TextSpan(text: tok, style: ts));
          continue;
        }

        // Highlight {VAR} placeholders within the text segment
        var pos = 0;
        for (final vm in _varRe.allMatches(tok)) {
          if (vm.start > pos) {
            out.add(TextSpan(text: tok.substring(pos, vm.start), style: ts));
          }
          out.add(_varBadge(vm.group(0)!, ts, bold, italic));
          pos = vm.end;
        }
        if (pos < tok.length) {
          out.add(TextSpan(text: tok.substring(pos), style: ts));
        }
      }
    }

    return out;
  }

  WidgetSpan _varBadge(
    String tag,
    TextStyle currentStyle,
    bool bold,
    bool italic,
  ) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.emailVarBadgeFill,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColors.emailCategoryReminder.withValues(alpha: 0.4),
          ),
        ),
        child: Text(
          tag,
          style: currentStyle.copyWith(
            color: AppColors.emailCategoryReminder,
            fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            fontStyle: italic ? FontStyle.italic : null,
            fontSize: 11,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spans = _spans(context);
    if (spans.isEmpty) return const SizedBox.shrink();
    return RichText(text: TextSpan(children: spans));
  }
}
