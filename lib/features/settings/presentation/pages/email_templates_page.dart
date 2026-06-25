import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_nav_drawer.dart';
import '../../domain/entities/email_template.dart';
import '../providers/email_templates_providers.dart';
import '../widgets/add_edit_email_template_dialog.dart';
import '../widgets/email_template_section.dart';
import '../widgets/view_email_template_dialog.dart';

class EmailTemplatesPage extends ConsumerStatefulWidget {
  const EmailTemplatesPage({super.key});

  @override
  ConsumerState<EmailTemplatesPage> createState() =>
      _EmailTemplatesPageState();
}

class _EmailTemplatesPageState extends ConsumerState<EmailTemplatesPage> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      setState(() => _query = _searchCtrl.text);
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(emailTemplatesProvider);
    final isMobile = context.screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: const Text('Royal HRMS'),
      ),
      drawer: const AppNavDrawer(),
      body: asyncState.when(
        loading: () => const AppLoader(message: 'Loading templates…'),
        error: (e, _) => AppErrorView(
          message: e is AppException
              ? Failure.fromException(e).message
              : e.toString(),
          onRetry: () => ref.invalidate(emailTemplatesProvider),
        ),
        data: (state) {
          final allTemplates = state.search(_query);

          List<EmailTemplate> filtered(EmailTemplateCategory cat) =>
              allTemplates.where((t) => t.category == cat).toList();

          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 28,
              vertical: 24,
            ),
            children: [
              // ── Page header ──────────────────────────────────────────────
              _PageHeader(
                isMobile: isMobile,
                searchCtrl: _searchCtrl,
                onAddTemplate: () =>
                    AddEditEmailTemplateDialog.show(context),
                onBack: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(height: 24),
              // ── Document Templates ────────────────────────────────────────
              EmailTemplateSection(
                category: EmailTemplateCategory.document,
                templates: filtered(EmailTemplateCategory.document),
                headerColor: AppColors.emailCategoryDocument,
                headerIcon: Icons.description_outlined,
                title: 'Document Templates',
                onView: (t) => ViewEmailTemplateDialog.show(context, t),
                onEdit: (t) =>
                    AddEditEmailTemplateDialog.show(context, existing: t),
                onToggleActive: (t, v) =>
                    ref.read(emailTemplatesProvider.notifier).toggleActive(t.id, v),
              ),
              const SizedBox(height: 24),
              // ── Notification Templates ────────────────────────────────────
              EmailTemplateSection(
                category: EmailTemplateCategory.notification,
                templates: filtered(EmailTemplateCategory.notification),
                headerColor: AppColors.emailCategoryNotification,
                headerIcon: Icons.notifications_outlined,
                title: 'Notification Templates',
                onView: (t) => ViewEmailTemplateDialog.show(context, t),
                onEdit: (t) =>
                    AddEditEmailTemplateDialog.show(context, existing: t),
                onToggleActive: (t, v) =>
                    ref.read(emailTemplatesProvider.notifier).toggleActive(t.id, v),
              ),
              const SizedBox(height: 24),
              // ── Reminder Templates ────────────────────────────────────────
              EmailTemplateSection(
                category: EmailTemplateCategory.reminder,
                templates: filtered(EmailTemplateCategory.reminder),
                headerColor: AppColors.emailCategoryReminder,
                headerIcon: Icons.alarm_outlined,
                title: 'Reminder Templates',
                onView: (t) => ViewEmailTemplateDialog.show(context, t),
                onEdit: (t) =>
                    AddEditEmailTemplateDialog.show(context, existing: t),
                onToggleActive: (t, v) =>
                    ref.read(emailTemplatesProvider.notifier).toggleActive(t.id, v),
              ),
              const SizedBox(height: 24),
              // ── Wish Templates ─────────────────────────────────────────────
              EmailTemplateSection(
                category: EmailTemplateCategory.wish,
                templates: filtered(EmailTemplateCategory.wish),
                headerColor: AppColors.emailCategoryWish,
                headerIcon: Icons.celebration_outlined,
                title: 'Wish Templates',
                onView: (t) => ViewEmailTemplateDialog.show(context, t),
                onEdit: (t) =>
                    AddEditEmailTemplateDialog.show(context, existing: t),
                onToggleActive: (t, v) =>
                    ref.read(emailTemplatesProvider.notifier).toggleActive(t.id, v),
              ),
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Page header: title + subtitle + search + action buttons
// ---------------------------------------------------------------------------

class _PageHeader extends StatelessWidget {
  const _PageHeader({
    required this.isMobile,
    required this.searchCtrl,
    required this.onAddTemplate,
    required this.onBack,
  });

  final bool isMobile;
  final TextEditingController searchCtrl;
  final VoidCallback onAddTemplate;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Templates',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Customize transactional email messages sent by Royal HRMS.',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: mutedColor,
                    ),
                  ),
                ],
              ),
            ),
            if (!isMobile) ...[
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back, size: 15),
                label: const Text('Back'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 38),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FilledButton.icon(
                onPressed: onAddTemplate,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Template'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 38),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        // Search bar
        _SearchBar(controller: searchCtrl),
        if (isMobile) ...[
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back, size: 15),
                  label: const Text('Back'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: onAddTemplate,
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add Template'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
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

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final borderColor =
        isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final fillColor =
        isDark ? AppColors.darkFieldFill : AppColors.lightSurface;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(Icons.search, size: 18, color: mutedColor),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search templates...',
                hintStyle: TextStyle(color: mutedColor, fontSize: 14),
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.close, size: 16, color: mutedColor),
              onPressed: controller.clear,
              visualDensity: VisualDensity.compact,
              tooltip: 'Clear',
            ),
        ],
      ),
    );
  }
}
