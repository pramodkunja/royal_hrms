import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_nav_drawer.dart';
import '../../domain/entities/dashboard_overview.dart';
import '../providers/dashboard_controller.dart';
import '../providers/dashboard_state.dart';
import '../widgets/anniversary_card.dart';
import '../widgets/birthday_card.dart';
import '../widgets/dashboard_app_bar.dart';
import '../widgets/department_headcount_card.dart';
import '../widgets/expandable_fab.dart';
import '../widgets/hiring_trend_card.dart';
import '../widgets/hr_action_queue_card.dart';
import '../widgets/live_activity_card.dart';
import '../widgets/recruitment_funnel_card.dart';
import '../widgets/welcome_card.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(dashboardControllerProvider.notifier).load(),
    );
  }

  void _navigateForAction(HrActionItem item) {
    final path = switch (item.type) {
      HrActionType.leave => RoutePaths.leave,
      HrActionType.separation => RoutePaths.employees,
      HrActionType.smtp => RoutePaths.settings,
      HrActionType.document => RoutePaths.employees,
    };
    context.push(path);
  }

  void _sendBirthdayWish(BirthdayEntry entry) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Birthday wish sent to ${entry.name}!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardControllerProvider);

    return Scaffold(
      appBar: const DashboardAppBar(),
      drawer: const AppNavDrawer(),
      floatingActionButton: ExpandableFab(
        actions: [
          FabAction(
            icon: Icons.person_add_alt_1_outlined,
            label: 'Add Employee',
            onTap: () => context.push(RoutePaths.employees),
          ),
          FabAction(
            icon: Icons.group_add_outlined,
            label: 'Add Candidate',
            onTap: () => context.push(RoutePaths.employees),
          ),
          FabAction(
            icon: Icons.campaign_outlined,
            label: 'Post Announcement',
            onTap: () => context.push(RoutePaths.notifications),
          ),
          FabAction(
            icon: Icons.payments_outlined,
            label: 'Run Payroll',
            onTap: () => context.push(RoutePaths.payroll),
          ),
        ],
      ),
      body: switch (state.status) {
        DashboardStatus.initial || DashboardStatus.loading => const AppLoader(),
        DashboardStatus.failure => AppErrorView(
          message: state.failure?.message ?? 'Unable to load dashboard.',
          onRetry: () => ref.read(dashboardControllerProvider.notifier).load(),
        ),
        DashboardStatus.loaded => _DashboardContent(
          overview: state.overview!,
          onRefresh: () =>
              ref.read(dashboardControllerProvider.notifier).load(),
          onViewFunnel: () => context.push(RoutePaths.reports),
          onActionTap: _navigateForAction,
          onSendWish: _sendBirthdayWish,
        ),
      },
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({
    required this.overview,
    required this.onRefresh,
    required this.onViewFunnel,
    required this.onActionTap,
    required this.onSendWish,
  });

  final DashboardOverview overview;
  final Future<void> Function() onRefresh;
  final VoidCallback onViewFunnel;
  final ValueChanged<HrActionItem> onActionTap;
  final ValueChanged<BirthdayEntry> onSendWish;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          WelcomeCard(summary: overview.workforceSummary),
          const SizedBox(height: 16),
          HiringTrendCard(points: overview.hiringTrend),
          const SizedBox(height: 16),
          RecruitmentFunnelCard(
            month: DateFormat('MMMM').format(DateTime.now()),
            stages: overview.recruitmentFunnel,
            onViewAll: onViewFunnel,
          ),
          const SizedBox(height: 16),
          BirthdayCard(
            entries: overview.todaysBirthdays,
            onSendWish: onSendWish,
          ),
          const SizedBox(height: 16),
          AnniversaryCard(entries: overview.workAnniversaries),
          const SizedBox(height: 16),
          HrActionQueueCard(
            items: overview.hrActionQueue,
            onItemTap: onActionTap,
          ),
          const SizedBox(height: 16),
          DepartmentHeadcountCard(departments: overview.departmentHeadcount),
          const SizedBox(height: 16),
          LiveActivityCard(entries: overview.liveActivity),
        ],
      ),
    );
  }
}
