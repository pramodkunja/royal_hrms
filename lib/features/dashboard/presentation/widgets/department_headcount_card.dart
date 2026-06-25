import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_chart_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/dashboard_overview.dart';
import 'dashboard_section_header.dart';

/// Donut chart of headcount by department, with the running total shown
/// in the center and a count-per-department legend below.
class DepartmentHeadcountCard extends StatelessWidget {
  const DepartmentHeadcountCard({super.key, required this.departments});

  final List<DepartmentHeadcount> departments;

  @override
  Widget build(BuildContext context) {
    final total = departments.fold<int>(0, (sum, d) => sum + d.count);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSectionHeader(
            icon: Icons.donut_large_outlined,
            title: 'Department Headcount',
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 50,
                    sections: [
                      for (var i = 0; i < departments.length; i++)
                        PieChartSectionData(
                          value: departments[i].count.toDouble(),
                          color:
                              AppChartColors.categorical[i %
                                  AppChartColors.categorical.length],
                          radius: 28,
                          showTitle: false,
                        ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$total',
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text('Total', style: context.textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < departments.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppChartColors
                          .categorical[i % AppChartColors.categorical.length],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      departments[i].name,
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                  Text(
                    '${departments[i].count}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
