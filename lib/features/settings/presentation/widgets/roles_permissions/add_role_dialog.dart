import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theme/app_colors.dart';
import 'permission_matrix_data.dart';

class AddRoleDialog extends StatefulWidget {
  const AddRoleDialog({super.key});

  @override
  State<AddRoleDialog> createState() => _AddRoleDialogState();
}

class _AddRoleDialogState extends State<AddRoleDialog> {
  final _nameCtrl = TextEditingController();
  final Set<String> _selected = {};

  int get _total => kModulePerms.fold(0, (s, m) => s + m.actions.length);
  String _key(String mod, String action) => '$mod.$action';

  void _toggleAction(String mod, String action, bool on) => setState(() {
    if (on) { _selected.add(_key(mod, action)); } else { _selected.remove(_key(mod, action)); }
  });

  void _toggleModule(ModulePerm mod) => setState(() {
    final allSelected = mod.actions.every((a) => _selected.contains(_key(mod.module, a)));
    for (final a in mod.actions) {
      if (allSelected) { _selected.remove(_key(mod.module, a)); } else { _selected.add(_key(mod.module, a)); }
    }
  });

  void _applyPreset(String name) {
    setState(() {
      _selected.clear();
      switch (name) {
        case 'Full Admin':
          for (final m in kModulePerms) { for (final a in m.actions) { _selected.add(_key(m.module, a)); } }
        case 'View Only':
          for (final m in kModulePerms) {
            if (m.actions.contains('View')) { _selected.add(_key(m.module, 'View')); }
            if (m.actions.contains('Export')) { _selected.add(_key(m.module, 'Export')); }
          }
        case 'Manager':
          _selected.addAll({'Announcements.View', 'Attendance.Create', 'Attendance.Edit', 'Attendance.Export', 'Attendance.View', 'Documents.View', 'Employees.View', 'Expenses.Approve', 'Expenses.Create', 'Expenses.Delete', 'Expenses.Edit', 'Expenses.View', 'Leave.Approve', 'Leave.Create', 'Leave.Delete', 'Leave.Edit', 'Leave.View', 'Payroll.View', 'Referrals.Create', 'Referrals.View'});
        case 'Employee':
          _selected.addAll({'Attendance.View', 'Attendance.Create', 'Documents.View', 'Expenses.View', 'Expenses.Create', 'Leave.View', 'Leave.Create', 'Payroll.View', 'Referrals.Create', 'Referrals.View'});
      }
    });
  }

  @override
  void dispose() { _nameCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceBg = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: surfaceBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 480, maxHeight: MediaQuery.sizeOf(context).height * 0.88),
        child: Column(children: [
          _DialogHeader(isDark: isDark, borderColor: borderColor),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: _DialogBody(isDark: isDark, borderColor: borderColor, nameCtrl: _nameCtrl, selected: _selected, total: _total, onToggleAction: _toggleAction, onToggleModule: _toggleModule, onPreset: _applyPreset, onSelectAll: () => setState(() { for (final m in kModulePerms) { for (final a in m.actions) { _selected.add(_key(m.module, a)); } } }), onClear: () => setState(() => _selected.clear())),
          )),
          _DialogFooter(isDark: isDark, borderColor: borderColor, onCancel: () => Navigator.of(context).pop()),
        ]),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({required this.isDark, required this.borderColor});
  final bool isDark;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 12, 18),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderColor))),
      child: Row(children: [
        Text('Add New Role', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface)),
        const Spacer(),
        IconButton(icon: const Icon(Icons.close_rounded, size: 20), onPressed: () => Navigator.of(context).pop(), color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
      ]),
    );
  }
}

class _DialogBody extends StatelessWidget {
  const _DialogBody({required this.isDark, required this.borderColor, required this.nameCtrl, required this.selected, required this.total, required this.onToggleAction, required this.onToggleModule, required this.onPreset, required this.onSelectAll, required this.onClear});
  final bool isDark;
  final Color borderColor;
  final TextEditingController nameCtrl;
  final Set<String> selected;
  final int total;
  final void Function(String, String, bool) onToggleAction;
  final void Function(ModulePerm) onToggleModule;
  final void Function(String) onPreset;
  final VoidCallback onSelectAll, onClear;

  @override
  Widget build(BuildContext context) {
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final fieldBg = isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Role Name *', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: onSurface)),
      const SizedBox(height: 8),
      TextField(controller: nameCtrl, decoration: InputDecoration(hintText: 'e.g. Finance Manager', filled: true, fillColor: fieldBg, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)), style: GoogleFonts.poppins(fontSize: 13)),
      const SizedBox(height: 20),
      Row(children: [
        Text('Permissions *', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: onSurface)),
        const Spacer(),
        TextButton(onPressed: onSelectAll, child: Text('Select all', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.primary))),
        TextButton(onPressed: onClear, child: Text('Clear', style: GoogleFonts.poppins(fontSize: 11, color: mutedColor))),
      ]),
      const SizedBox(height: 6),
      // Quick presets
      Wrap(spacing: 8, children: ['Full Admin', 'View Only', 'Manager', 'Employee'].map((p) => OutlinedButton.icon(
        onPressed: () => onPreset(p),
        icon: Icon(p == 'Full Admin' ? Icons.admin_panel_settings_outlined : p == 'View Only' ? Icons.visibility_outlined : Icons.person_outlined, size: 13),
        label: Text(p, style: GoogleFonts.poppins(fontSize: 11)),
        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), side: BorderSide(color: borderColor), foregroundColor: onSurface, visualDensity: VisualDensity.compact),
      )).toList()),
      const SizedBox(height: 10),
      Text('${selected.length} of $total permissions selected', style: GoogleFonts.poppins(fontSize: 11, color: mutedColor)),
      const SizedBox(height: 14),
      ...kModulePerms.map((m) => _ModuleGroup(mod: m, selected: selected, isDark: isDark, borderColor: borderColor, onToggleAction: onToggleAction, onToggleModule: onToggleModule)),
    ]);
  }
}

class _ModuleGroup extends StatelessWidget {
  const _ModuleGroup({required this.mod, required this.selected, required this.isDark, required this.borderColor, required this.onToggleAction, required this.onToggleModule});
  final ModulePerm mod;
  final Set<String> selected;
  final bool isDark;
  final Color borderColor;
  final void Function(String, String, bool) onToggleAction;
  final void Function(ModulePerm) onToggleModule;

  String _key(String action) => '${mod.module}.$action';
  int get _count => mod.actions.where((a) => selected.contains(_key(a))).length;
  bool get _allSelected => _count == mod.actions.length;

  @override
  Widget build(BuildContext context) {
    final onSurface = isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        InkWell(
          onTap: () => onToggleModule(mod),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(children: [
              Checkbox(value: _allSelected, tristate: _count > 0 && !_allSelected, onChanged: (_) => onToggleModule(mod), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
              const SizedBox(width: 6),
              Icon(mod.icon, size: 14, color: mutedColor),
              const SizedBox(width: 6),
              Text(mod.module, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: onSurface)),
              const Spacer(),
              Text('$_count/${mod.actions.length}', style: GoogleFonts.poppins(fontSize: 10, color: mutedColor)),
            ]),
          ),
        ),
        Divider(height: 1, color: borderColor),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
          child: Wrap(
            spacing: 4,
            runSpacing: 0,
            children: mod.actions.map((action) => SizedBox(
              width: 148,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Checkbox(value: selected.contains(_key(action)), onChanged: (v) => onToggleAction(mod.module, action, v ?? false), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
                const SizedBox(width: 4),
                Text(action, style: GoogleFonts.poppins(fontSize: 12, color: onSurface)),
              ]),
            )).toList(),
          ),
        ),
      ]),
    );
  }
}

class _DialogFooter extends StatelessWidget {
  const _DialogFooter({required this.isDark, required this.borderColor, required this.onCancel});
  final bool isDark;
  final Color borderColor;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: borderColor))),
      child: Row(children: [
        const Spacer(),
        OutlinedButton(onPressed: onCancel, style: OutlinedButton.styleFrom(side: BorderSide(color: borderColor), foregroundColor: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted), child: Text('Cancel', style: GoogleFonts.poppins(fontSize: 13))),
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: onCancel,
          icon: const Icon(Icons.add_rounded, size: 16),
          label: Text('Add Role', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
          style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
        ),
      ]),
    );
  }
}
