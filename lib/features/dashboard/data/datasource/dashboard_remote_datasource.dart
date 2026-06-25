import '../../../../core/network/api_client.dart';
import '../../domain/entities/dashboard_overview.dart';
import '../models/dashboard_overview_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardOverviewModel> getDashboardOverview();
}

/// Returns mock data shaped exactly like the future `/dashboard/overview`
/// API response. Swapping this for a real [ApiClient] call later is a
/// pure substitution — callers only ever see [DashboardOverviewModel].
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  DashboardRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  ApiClient get apiClient => _apiClient;

  @override
  Future<DashboardOverviewModel> getDashboardOverview() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockOverview;
  }

  static final DashboardOverviewModel _mockOverview = DashboardOverviewModel(
    workforceSummary: const WorkforceSummaryModel(
      greetingName: 'Kavitha',
      dateLabel: 'Wednesday, 24 June 2026',
      candidatesInPipeline: 4,
      birthdaysToday: 2,
      totalWorkforce: 6,
      pendingActions: 2,
      activeInterviews: 4,
      payrollAmountLabel: '₹4.16L',
    ),
    hiringTrend: const [
      HiringTrendPointModel(month: 'Jan', hires: 2, exits: 1),
      HiringTrendPointModel(month: 'Feb', hires: 1, exits: 0),
      HiringTrendPointModel(month: 'Mar', hires: 3, exits: 1),
      HiringTrendPointModel(month: 'Apr', hires: 2, exits: 0),
      HiringTrendPointModel(month: 'May', hires: 1, exits: 1),
      HiringTrendPointModel(month: 'Jun', hires: 1, exits: 1),
    ],
    recruitmentFunnel: const [
      FunnelStageModel(label: 'Interviews Scheduled', count: 4),
      FunnelStageModel(label: 'Interviewed', count: 2),
      FunnelStageModel(label: 'Selected', count: 1),
      FunnelStageModel(label: 'Details Submitted', count: 0),
      FunnelStageModel(label: 'Onboarded', count: 0),
    ],
    todaysBirthdays: const [
      BirthdayEntryModel(
        name: 'Meena Iyer',
        subtitle: 'Finance Manager · Turning 38',
      ),
      BirthdayEntryModel(
        name: 'Vikram Das',
        subtitle: 'Candidate · Interview today',
      ),
    ],
    workAnniversaries: const [
      AnniversaryEntryModel(
        name: 'Arjun Mehta',
        initials: 'AM',
        detail: 'Completed 4 years on Jan 15 · Engineering',
        years: 4,
      ),
      AnniversaryEntryModel(
        name: 'Meena Iyer',
        initials: 'MI',
        detail: 'Completes 4 years on Aug 5 · Finance',
        years: 4,
      ),
    ],
    hrActionQueue: const [
      HrActionItemModel(
        type: HrActionType.leave,
        title: '2 leave approvals pending',
        subtitle: 'Including 5-day EL request from Meena',
      ),
      HrActionItemModel(
        type: HrActionType.separation,
        title: '1 separation in notice period',
        subtitle: 'Suresh Kumar — FnF pending',
      ),
      HrActionItemModel(
        type: HrActionType.smtp,
        title: 'SMTP test recommended',
        subtitle: 'Last verified 14 days ago',
      ),
      HrActionItemModel(
        type: HrActionType.document,
        title: '1 document verification pending',
        subtitle: 'Aadhaar verification — Vikram Das',
      ),
    ],
    departmentHeadcount: const [
      DepartmentHeadcountModel(name: 'Engineering', count: 2),
      DepartmentHeadcountModel(name: 'HR', count: 1),
      DepartmentHeadcountModel(name: 'Finance', count: 1),
      DepartmentHeadcountModel(name: 'Sales', count: 1),
      DepartmentHeadcountModel(name: 'IT', count: 1),
    ],
    liveActivity: const [
      ActivityEntryModel(
        type: ActivityType.onboarded,
        title: 'Priya Sharma onboarded',
        timeLabel: 'Today, 9:00 AM',
      ),
      ActivityEntryModel(
        type: ActivityType.emailSent,
        title: 'Selection email sent to Priya',
        timeLabel: 'Jun 10, 3:32 PM',
      ),
      ActivityEntryModel(
        type: ActivityType.interview,
        title: 'Interview scheduled with Vikram Das',
        timeLabel: 'Jun 9, 11:00 AM',
      ),
      ActivityEntryModel(
        type: ActivityType.leaveApproved,
        title: 'Leave approved for Arjun Mehta',
        timeLabel: 'Jun 8, 4:15 PM',
      ),
    ],
  );
}
