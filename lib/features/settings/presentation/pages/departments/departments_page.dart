import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/widgets/app_error_view.dart';
import '../../../../../core/widgets/app_loader.dart';
import '../../providers/departments_providers.dart';
import '../../widgets/departments/departments_mobile_layout.dart';
import '../../widgets/departments/departments_side_layout.dart';

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
    final isSideBySide = MediaQuery.sizeOf(context).width >= 700;

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
              ? DeptSideBySideLayout(
                  departments: filtered,
                  allDepts: allDepts,
                  state: state,
                  searchCtrl: _searchCtrl,
                )
              : DeptMobileLayout(
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
