import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import 'email_html_preview.dart';

class EmailTemplateLivePreviewPanel extends StatelessWidget {
  const EmailTemplateLivePreviewPanel({
    super.key,
    required this.subject,
    required this.body,
  });

  final String subject;
  final String body;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final bgColor =
        isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;
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
