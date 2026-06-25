import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/entities/department.dart';
import '../providers/departments_providers.dart';
import '../widgets/add_edit_department_dialog.dart';

// ---------------------------------------------------------------------------
// Avatar colour palette
// ---------------------------------------------------------------------------

const _kAvatarColors = [
  AppColors.primary,
  AppColors.emailCategoryNotification,
  AppColors.emailCategoryWish,
  AppColors.emailCategoryReminder,
  AppColors.emailCategoryDocument,
];

Color _avatarColor(int index) => _kAvatarColors[index % _kAvatarColors.length];

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class DepartmentsPage extends ConsumerStatefulWidget {
  const DepartmentsPage({super.key});

  @override
  ConsumerState<DepartmentsPage> createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends ConsumerState<DepartmentsPage> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(
      () => setState(() => _query = _searchCtrl.text.toLowerCase().trim()),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(departmentsProvider);
    final isSideBySide = context.screenSize.width >= 700;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: 'Back',
        ),
        title: const Text('Departments & Designations'),
      ),
      body: asyncState.when(
        loading: () => const AppLoader(message: 'Loading departments…'),
        error: (e, _) => AppErrorView(
          message: e is AppException
              ? Failure.fromException(e).message
              : e.toString(),
          onRetry: () => ref.invalidate(departmentsProvider),
        ),
        data: (state) {
          final allDepts = state.departments;
          final filtered = _query.isEmpty
              ? allDepts
              : allDepts
                  .where(
                    (d) =>
                        d.name.toLowerCase().contains(_query) ||
                        d.description.toLowerCase().contains(_query),
                  )
                  .toList();

          return isSideBySide
              ? _SideBySideLayout(
                  departments: filtered,
                  allDepts: allDepts,
                  state: state,
                  searchCtrl: _searchCtrl,
                )
              : _MobileLayout(
                  departments: filtered,
                  allDepts: allDepts,
                  state: state,
                  searchCtrl: _searchCtrl,
                );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mobile layout — accordion inline expansion
// ---------------------------------------------------------------------------

class _MobileLayout extends ConsumerWidget {
  const _MobileLayout({
    required this.departments,
    required this.allDepts,
    required this.state,
    required this.searchCtrl,
  });

  final List<Department> departments;
  final List<Department> allDepts;
  final DepartmentsState state;
  final TextEditingController searchCtrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final borderColor =
        isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final bgColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    return ColoredBox(
      color: bgColor,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        children: [
          // Add Department button
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: () => AddEditDepartmentDialog.show(context),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Department'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 40),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Stats
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.account_tree_outlined,
                  iconColor: AppColors.primary,
                  count: state.departments.length,
                  label: 'Total\nDepartments',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _StatCard(
                  icon: Icons.badge_outlined,
                  iconColor: AppColors.emailCategoryNotification,
                  count: state.totalDesignations,
                  label: 'Total\nDesignations',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _StatCard(
            icon: Icons.check_circle_outline,
            iconColor: AppColors.success,
            count: state.activeDepartmentCount,
            label: 'Active Departments',
          ),
          const SizedBox(height: 20),

          // Search
          _SearchBar(
            controller: searchCtrl,
            hintText: 'Search departments...',
            mutedColor: mutedColor,
            isDark: isDark,
            borderColor: borderColor,
          ),
          const SizedBox(height: 14),

          // Department accordion list
          if (departments.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text(
                  'No departments found',
                  style:
                      context.textTheme.bodyMedium?.copyWith(color: mutedColor),
                ),
              ),
            )
          else
            ...List.generate(departments.length, (index) {
              final dept = departments[index];
              final globalIndex = allDepts.indexWhere((d) => d.id == dept.id);
              final color =
                  _avatarColor(globalIndex < 0 ? index : globalIndex);
              final isSelected = dept.id == state.selectedDepartmentId;
              // Use allDepts version — has loaded designations after selection
              final fullDept = isSelected
                  ? (state.selectedDepartment ?? dept)
                  : dept;

              return _DepartmentAccordionItem(
                department: dept,
                fullDepartment: fullDept,
                avatarColor: color,
                isSelected: isSelected,
                isDark: isDark,
                borderColor: borderColor,
                mutedColor: mutedColor,
                onTap: () => ref
                    .read(departmentsProvider.notifier)
                    .selectDepartment(isSelected ? null : dept.id),
                onEdit: () =>
                    AddEditDepartmentDialog.show(context, existing: dept),
                onDelete: () =>
                    _confirmDeleteDepartment(context, ref, dept),
              );
            }),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteDepartment(
    BuildContext context,
    WidgetRef ref,
    Department dept,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Department'),
        content: Text(
          'Are you sure you want to delete "${dept.name}"? '
          'This will also remove all its designations.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await ref.read(departmentsProvider.notifier).deleteDepartment(dept.id);
      } on AppException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Failure.fromException(e).message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Accordion item: card header + inline expansion panel
// ---------------------------------------------------------------------------

class _DepartmentAccordionItem extends ConsumerWidget {
  const _DepartmentAccordionItem({
    required this.department,
    required this.fullDepartment,
    required this.avatarColor,
    required this.isSelected,
    required this.isDark,
    required this.borderColor,
    required this.mutedColor,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final Department department;
  final Department fullDepartment;
  final Color avatarColor;
  final bool isSelected;
  final bool isDark;
  final Color borderColor;
  final Color mutedColor;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final selectedBg = AppColors.primary.withValues(alpha: 0.05);
    final activeBorder = AppColors.primary;

    final cardRadius = isSelected
        ? const BorderRadius.vertical(top: Radius.circular(14))
        : BorderRadius.circular(14);

    final cardBorder = isSelected
        ? Border(
            top: BorderSide(color: activeBorder, width: 1.5),
            left: BorderSide(color: activeBorder, width: 1.5),
            right: BorderSide(color: activeBorder, width: 1.5),
          )
        : Border.all(color: borderColor);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Card header ─────────────────────────────────────────────────
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: cardRadius,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? selectedBg : surfaceColor,
                  borderRadius: cardRadius,
                  border: cardBorder,
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: avatarColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          department.name.isNotEmpty
                              ? department.name[0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            color: avatarColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Name + meta
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            department.name,
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${department.designationCount} designation${department.designationCount == 1 ? '' : 's'}',
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: mutedColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Active/Inactive badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: department.isActive
                            ? AppColors.success.withValues(alpha: 0.10)
                            : AppColors.error.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        department.isActive ? 'Active' : 'Inactive',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: department.isActive
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Edit
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: mutedColor,
                      ),
                      onPressed: onEdit,
                      tooltip: 'Edit',
                      visualDensity: VisualDensity.compact,
                    ),
                    // Delete
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: AppColors.error,
                      ),
                      onPressed: onDelete,
                      tooltip: 'Delete',
                      visualDensity: VisualDensity.compact,
                    ),
                    // Chevron
                    Icon(
                      isSelected
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: isSelected ? AppColors.primary : mutedColor,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Inline expansion panel ───────────────────────────────────
          if (isSelected)
            Container(
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(14),
                ),
                border: Border(
                  bottom:
                      BorderSide(color: AppColors.primary, width: 1.5),
                  left: BorderSide(color: AppColors.primary, width: 1.5),
                  right: BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
              child: _DesignationExpansion(
                department: fullDepartment,
                avatarColor: avatarColor,
                isDark: isDark,
                borderColor: borderColor,
                mutedColor: mutedColor,
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Designation expansion content (inside accordion)
// ---------------------------------------------------------------------------

class _DesignationExpansion extends ConsumerWidget {
  const _DesignationExpansion({
    required this.department,
    required this.avatarColor,
    required this.isDark,
    required this.borderColor,
    required this.mutedColor,
  });

  final Department department;
  final Color avatarColor;
  final bool isDark;
  final Color borderColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designations = department.designations;
    final chipBg =
        isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Action buttons row
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
          child: Row(
            children: [
              // People chip
              _InfoChip(
                icon: Icons.people_outline,
                label: '${department.employeeCount} People',
                bgColor: chipBg,
                textColor: mutedColor,
              ),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () => AddEditDepartmentDialog.show(
                  context,
                  existing: department,
                ),
                icon: const Icon(Icons.edit_outlined, size: 14),
                label: const Text('Edit'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textStyle: const TextStyle(fontSize: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: () => AddEditDesignationDialog.show(
                  context,
                  departmentId: department.id,
                  departmentName: department.name,
                ),
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Add'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textStyle: const TextStyle(fontSize: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),
        Divider(height: 1, color: borderColor),

        // Designations header
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
          child: Text(
            'Designations (${department.designationCount})',
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: mutedColor,
            ),
          ),
        ),

        // Designation cards
        if (designations.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
            child: Text(
              'No designations yet — tap Add to create one.',
              style: context.textTheme.bodySmall?.copyWith(
                color: mutedColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(designations.length, (i) {
                final desig = designations[i];
                return _DesignationCard(
                  designation: desig,
                  avatarColor: _avatarColor(i),
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                  isDark: isDark,
                  onEdit: () => AddEditDesignationDialog.show(
                    context,
                    departmentId: department.id,
                    departmentName: department.name,
                    existing: desig,
                  ),
                  onDelete: () =>
                      _confirmDeleteDesignation(context, ref, desig),
                );
              }),
            ),
          ),
      ],
    );
  }

  Future<void> _confirmDeleteDesignation(
    BuildContext context,
    WidgetRef ref,
    Designation desig,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Designation'),
        content:
            Text('Are you sure you want to delete "${desig.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await ref
            .read(departmentsProvider.notifier)
            .deleteDesignation(desig.id);
      } on AppException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Failure.fromException(e).message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Desktop side-by-side layout
// ---------------------------------------------------------------------------

class _SideBySideLayout extends ConsumerWidget {
  const _SideBySideLayout({
    required this.departments,
    required this.allDepts,
    required this.state,
    required this.searchCtrl,
  });

  final List<Department> departments;
  final List<Department> allDepts;
  final DepartmentsState state;
  final TextEditingController searchCtrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.theme.brightness == Brightness.dark;
    final borderColor =
        isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final bgColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return ColoredBox(
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header + Add button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Departments & Designations',
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Global organisation structure — shared across all branches',
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: mutedColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: () => AddEditDepartmentDialog.show(context),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add Department'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 40),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Stats row
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.account_tree_outlined,
                    iconColor: AppColors.primary,
                    count: state.departments.length,
                    label: 'Total Departments',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.badge_outlined,
                    iconColor: AppColors.emailCategoryNotification,
                    count: state.totalDesignations,
                    label: 'Total Designations',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.check_circle_outline,
                    iconColor: AppColors.success,
                    count: state.activeDepartmentCount,
                    label: 'Active Departments',
                  ),
                ),
              ],
            ),
          ),
          // Two-panel area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 380,
                    child: _DepartmentListPanel(
                      departments: departments,
                      allDepts: allDepts,
                      selectedId: state.selectedDepartmentId,
                      searchCtrl: searchCtrl,
                      isDark: isDark,
                      borderColor: borderColor,
                    ),
                  ),
                  Container(
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    color: borderColor,
                  ),
                  Expanded(
                    child: _DesignationPanel(state: state),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat card
// ---------------------------------------------------------------------------

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.count,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor =
        isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  label,
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: mutedColor),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Desktop left panel
// ---------------------------------------------------------------------------

class _DepartmentListPanel extends ConsumerWidget {
  const _DepartmentListPanel({
    required this.departments,
    required this.allDepts,
    required this.selectedId,
    required this.searchCtrl,
    required this.isDark,
    required this.borderColor,
  });

  final List<Department> departments;
  final List<Department> allDepts;
  final String? selectedId;
  final TextEditingController searchCtrl;
  final bool isDark;
  final Color borderColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: _SearchBar(
              controller: searchCtrl,
              hintText: 'Search departments...',
              mutedColor: mutedColor,
              isDark: isDark,
              borderColor: borderColor,
            ),
          ),
          Divider(height: 1, color: borderColor),
          if (departments.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(
                  'No departments found',
                  style:
                      context.textTheme.bodyMedium?.copyWith(color: mutedColor),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: departments.length,
              separatorBuilder: (_, _) =>
                  Divider(height: 1, color: borderColor),
              itemBuilder: (context, index) {
                final dept = departments[index];
                final globalIndex =
                    allDepts.indexWhere((d) => d.id == dept.id);
                final color =
                    _avatarColor(globalIndex < 0 ? index : globalIndex);
                final isSelected = dept.id == selectedId;

                return _DepartmentListRow(
                  department: dept,
                  avatarColor: color,
                  isSelected: isSelected,
                  mutedColor: mutedColor,
                  onTap: () => ref
                      .read(departmentsProvider.notifier)
                      .selectDepartment(isSelected ? null : dept.id),
                  onEdit: () =>
                      AddEditDepartmentDialog.show(context, existing: dept),
                  onDelete: () =>
                      _confirmDeleteDepartment(context, ref, dept),
                );
              },
            ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteDepartment(
    BuildContext context,
    WidgetRef ref,
    Department dept,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Department'),
        content: Text(
          'Are you sure you want to delete "${dept.name}"? '
          'This will also remove all its designations.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await ref
            .read(departmentsProvider.notifier)
            .deleteDepartment(dept.id);
      } on AppException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Failure.fromException(e).message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }
}

class _DepartmentListRow extends StatelessWidget {
  const _DepartmentListRow({
    required this.department,
    required this.avatarColor,
    required this.isSelected,
    required this.mutedColor,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final Department department;
  final Color avatarColor;
  final bool isSelected;
  final Color mutedColor;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final selectedBg = AppColors.primary.withValues(alpha: 0.07);

    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? selectedBg : null,
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: avatarColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  department.name.isNotEmpty
                      ? department.name[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: avatarColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          department.name,
                          style:
                              context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (department.isActive) ...[
                        const SizedBox(width: 6),
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${department.designationCount} designation${department.designationCount == 1 ? '' : 's'}',
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: mutedColor),
                  ),
                ],
              ),
            ),
            IconButton(
              icon:
                  Icon(Icons.edit_outlined, size: 16, color: mutedColor),
              onPressed: onEdit,
              tooltip: 'Edit',
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                size: 16,
                color: AppColors.error,
              ),
              onPressed: onDelete,
              tooltip: 'Delete',
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Desktop right panel
// ---------------------------------------------------------------------------

class _DesignationPanel extends ConsumerWidget {
  const _DesignationPanel({required this.state});

  final DepartmentsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.theme.brightness == Brightness.dark;
    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor =
        isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    final selectedDept = state.selectedDepartment;

    if (selectedDept == null) {
      return Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: _EmptyDesignationState(mutedColor: mutedColor),
      );
    }

    final selectedIndex =
        state.departments.indexWhere((d) => d.id == selectedDept.id);
    final avatarColor =
        _avatarColor(selectedIndex < 0 ? 0 : selectedIndex);

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: _DesignationListDesktop(
        department: selectedDept,
        avatarColor: avatarColor,
        mutedColor: mutedColor,
        borderColor: borderColor,
        isDark: isDark,
      ),
    );
  }
}

class _EmptyDesignationState extends StatelessWidget {
  const _EmptyDesignationState({required this.mutedColor});

  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.account_tree_outlined,
              size: 48,
              color: mutedColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No department selected',
              style: context.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              'Pick a department to view and manage its designations',
              style: context.textTheme.bodySmall?.copyWith(color: mutedColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Desktop designation list (rich header + cards)
class _DesignationListDesktop extends ConsumerWidget {
  const _DesignationListDesktop({
    required this.department,
    required this.avatarColor,
    required this.mutedColor,
    required this.borderColor,
    required this.isDark,
  });

  final Department department;
  final Color avatarColor;
  final Color mutedColor;
  final Color borderColor;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designations = department.designations;
    final designationCount = department.designationCount;
    final chipBg =
        isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: avatarColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        department.name.isNotEmpty
                            ? department.name[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          color: avatarColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                department.name,
                                style: context.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: department.isActive
                                    ? AppColors.success
                                        .withValues(alpha: 0.12)
                                    : chipBg,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                department.isActive
                                    ? 'Active'
                                    : 'Inactive',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: department.isActive
                                      ? AppColors.success
                                      : mutedColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _InfoChip(
                              icon: Icons.business_outlined,
                              label:
                                  '$designationCount Designation${designationCount == 1 ? '' : 's'}',
                              bgColor: chipBg,
                              textColor: mutedColor,
                            ),
                            const SizedBox(width: 8),
                            _InfoChip(
                              icon: Icons.people_outline,
                              label:
                                  '${department.employeeCount} People',
                              bgColor: chipBg,
                              textColor: mutedColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => AddEditDepartmentDialog.show(
                      context,
                      existing: department,
                    ),
                    icon: const Icon(Icons.edit_outlined, size: 15),
                    label: const Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 34),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 14),
                      textStyle: const TextStyle(fontSize: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilledButton.icon(
                    onPressed: () => AddEditDesignationDialog.show(
                      context,
                      departmentId: department.id,
                      departmentName: department.name,
                    ),
                    icon: const Icon(Icons.add, size: 15),
                    label: const Text('Add Designation'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 34),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 14),
                      textStyle: const TextStyle(fontSize: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(height: 1, color: borderColor),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
          child: Text(
            'Designations ($designationCount)',
            style: context.textTheme.labelLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        if (designations.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Text(
              'No designations yet — add one above',
              style: context.textTheme.bodySmall?.copyWith(
                color: mutedColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
            itemCount: designations.length,
            itemBuilder: (context, index) {
              final desig = designations[index];
              return _DesignationCard(
                designation: desig,
                avatarColor: _avatarColor(index),
                mutedColor: mutedColor,
                borderColor: borderColor,
                isDark: isDark,
                onEdit: () => AddEditDesignationDialog.show(
                  context,
                  departmentId: department.id,
                  departmentName: department.name,
                  existing: desig,
                ),
                onDelete: () =>
                    _confirmDeleteDesignation(context, ref, desig),
              );
            },
          ),
      ],
    );
  }

  Future<void> _confirmDeleteDesignation(
    BuildContext context,
    WidgetRef ref,
    Designation desig,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Designation'),
        content:
            Text('Are you sure you want to delete "${desig.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await ref
            .read(departmentsProvider.notifier)
            .deleteDesignation(desig.id);
      } on AppException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Failure.fromException(e).message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Info chip
// ---------------------------------------------------------------------------

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  final IconData icon;
  final String label;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: textColor),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Designation card (used in both mobile expansion and desktop panel)
// ---------------------------------------------------------------------------

class _DesignationCard extends StatelessWidget {
  const _DesignationCard({
    required this.designation,
    required this.avatarColor,
    required this.mutedColor,
    required this.borderColor,
    required this.isDark,
    required this.onEdit,
    required this.onDelete,
  });

  final Designation designation;
  final Color avatarColor;
  final Color mutedColor;
  final Color borderColor;
  final bool isDark;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final cardBg =
        isDark ? AppColors.darkFieldFill : AppColors.lightBackground;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: avatarColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                designation.name.isNotEmpty
                    ? designation.name[0].toUpperCase()
                    : '?',
                style: TextStyle(
                  color: avatarColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              designation.name,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: designation.isActive
                      ? AppColors.success
                      : AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                designation.isActive ? 'Active' : 'Inactive',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: designation.isActive
                      ? AppColors.success
                      : AppColors.error,
                ),
              ),
            ],
          ),
          IconButton(
            icon:
                Icon(Icons.edit_outlined, size: 15, color: mutedColor),
            onPressed: onEdit,
            tooltip: 'Edit',
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              size: 15,
              color: AppColors.error,
            ),
            onPressed: onDelete,
            tooltip: 'Delete',
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Search bar
// ---------------------------------------------------------------------------

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.hintText,
    required this.mutedColor,
    required this.isDark,
    required this.borderColor,
  });

  final TextEditingController controller;
  final String hintText;
  final Color mutedColor;
  final bool isDark;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final fillColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(Icons.search, size: 18, color: mutedColor),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
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
