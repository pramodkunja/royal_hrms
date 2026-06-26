import 'package:flutter/material.dart';

import '../../../domain/entities/email_template.dart';
import 'email_template_card.dart';

class EmailTemplateSection extends StatelessWidget {
  const EmailTemplateSection({
    super.key,
    required this.category,
    required this.templates,
    required this.headerColor,
    required this.headerIcon,
    required this.title,
    required this.onView,
    required this.onEdit,
    required this.onToggleActive,
  });

  final EmailTemplateCategory category;
  final List<EmailTemplate> templates;
  final Color headerColor;
  final IconData headerIcon;
  final String title;
  final ValueChanged<EmailTemplate> onView;
  final ValueChanged<EmailTemplate> onEdit;
  final void Function(EmailTemplate template, bool isActive) onToggleActive;

  @override
  Widget build(BuildContext context) {
    if (templates.isEmpty) return const SizedBox.shrink();
    final count = templates.length;
    final label = count == 1 ? '1 template' : '$count templates';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(
          color: headerColor,
          icon: headerIcon,
          title: title,
          countLabel: label,
        ),
        const SizedBox(height: 12),
        _TemplateGrid(
          templates: templates,
          accentColor: headerColor,
          onView: onView,
          onEdit: onEdit,
          onToggleActive: onToggleActive,
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.color,
    required this.icon,
    required this.title,
    required this.countLabel,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String countLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            countLabel,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _TemplateGrid extends StatelessWidget {
  const _TemplateGrid({
    required this.templates,
    required this.accentColor,
    required this.onView,
    required this.onEdit,
    required this.onToggleActive,
  });

  final List<EmailTemplate> templates;
  final Color accentColor;
  final ValueChanged<EmailTemplate> onView;
  final ValueChanged<EmailTemplate> onEdit;
  final void Function(EmailTemplate, bool) onToggleActive;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 600;

    if (isMobile) {
      return Column(
        children: templates
            .map(
              (t) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: EmailTemplateCard(
                  template: t,
                  accentColor: accentColor,
                  onView: () => onView(t),
                  onEdit: () => onEdit(t),
                  onToggleActive: (v) => onToggleActive(t, v),
                ),
              ),
            )
            .toList(),
      );
    }

    return _TwoColumnGrid(
      templates: templates,
      accentColor: accentColor,
      onView: onView,
      onEdit: onEdit,
      onToggleActive: onToggleActive,
    );
  }
}

class _TwoColumnGrid extends StatelessWidget {
  const _TwoColumnGrid({
    required this.templates,
    required this.accentColor,
    required this.onView,
    required this.onEdit,
    required this.onToggleActive,
  });

  final List<EmailTemplate> templates;
  final Color accentColor;
  final ValueChanged<EmailTemplate> onView;
  final ValueChanged<EmailTemplate> onEdit;
  final void Function(EmailTemplate, bool) onToggleActive;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < templates.length; i += 2) {
      final left = templates[i];
      final right = i + 1 < templates.length ? templates[i + 1] : null;
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: EmailTemplateCard(
                  template: left,
                  accentColor: accentColor,
                  onView: () => onView(left),
                  onEdit: () => onEdit(left),
                  onToggleActive: (v) => onToggleActive(left, v),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: right != null
                    ? EmailTemplateCard(
                        template: right,
                        accentColor: accentColor,
                        onView: () => onView(right),
                        onEdit: () => onEdit(right),
                        onToggleActive: (v) => onToggleActive(right, v),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}
