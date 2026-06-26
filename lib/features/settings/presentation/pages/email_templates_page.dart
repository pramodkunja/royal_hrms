import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/entities/email_template.dart';
import '../providers/email_templates_providers.dart';
import '../widgets/add_edit_email_template_dialog.dart';
import '../widgets/email_template_section.dart';
import '../widgets/email_templates_page_widgets.dart';
import '../widgets/view_email_template_dialog.dart';
import '../../../../core/theme/app_colors.dart';

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
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: 'Back',
        ),
        title: const Text('Email Templates'),
      ),
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
              EmailTemplatePageHeader(
                isMobile: isMobile,
                searchCtrl: _searchCtrl,
                onAddTemplate: () =>
                    AddEditEmailTemplateDialog.show(context),
                onBack: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(height: 24),
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
