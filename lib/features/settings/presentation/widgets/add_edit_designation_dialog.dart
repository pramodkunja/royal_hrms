import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/department.dart';
import '../providers/departments_providers.dart';
import 'department_dialog_chrome.dart';
import 'department_dialog_shared_widgets.dart';

class AddEditDesignationDialog extends ConsumerStatefulWidget {
  const AddEditDesignationDialog({
    super.key,
    required this.departmentId,
    required this.departmentName,
    this.existing,
  });

  final String departmentId;
  final String departmentName;
  final Designation? existing;

  static Future<void> show(
    BuildContext context, {
    required String departmentId,
    required String departmentName,
    Designation? existing,
  }) {
    return showDialog(
      context: context,
      builder: (_) => AddEditDesignationDialog(
        departmentId: departmentId,
        departmentName: departmentName,
        existing: existing,
      ),
    );
  }

  @override
  ConsumerState<AddEditDesignationDialog> createState() =>
      _AddEditDesignationDialogState();
}

class _AddEditDesignationDialogState
    extends ConsumerState<AddEditDesignationDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late bool _isActive;
  bool _isSaving = false;
  String? _errorMessage;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final desig = widget.existing;
    _nameCtrl = TextEditingController(text: desig?.name ?? '');
    _isActive = desig?.isActive ?? true;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _clearError() {
    if (_errorMessage != null) setState(() => _errorMessage = null);
  }

  Future<void> _submit() async {
    _clearError();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSaving = true);
    try {
      final designation = Designation(
        id: widget.existing?.id ?? '',
        name: _nameCtrl.text.trim(),
        isActive: _isActive,
        departmentId: widget.departmentId,
        departmentName: widget.departmentName,
      );

      if (_isEditing) {
        await ref
            .read(departmentsProvider.notifier)
            .updateDesignation(designation);
      } else {
        await ref
            .read(departmentsProvider.notifier)
            .addDesignation(designation);
      }

      if (mounted) Navigator.of(context).pop();
    } on AppException catch (e) {
      if (mounted) {
        setState(() => _errorMessage = Failure.fromException(e).message);
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.screenSize.width < 600;
    final isDark = context.theme.brightness == Brightness.dark;
    final chipBg = isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: isMobile
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 24)
          : const EdgeInsets.symmetric(horizontal: 80, vertical: 48),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DesigDialogHeader(
              isEditing: _isEditing,
              onClose: () => Navigator.of(context).pop(),
            ),
            const Divider(height: 1),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_errorMessage != null) ...[
                        DeptDialogErrorBanner(
                          message: _errorMessage!,
                          onDismiss: _clearError,
                        ),
                        const SizedBox(height: 16),
                      ],
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: chipBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.business_outlined,
                              size: 15,
                              color: mutedColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Department: ${widget.departmentName}',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: mutedColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const DeptDialogFieldLabel(
                        label: 'Designation Name',
                        required: true,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameCtrl,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'e.g. Senior Engineer',
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Designation name is required'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      DeptActiveCheckboxRow(
                        value: _isActive,
                        onChanged: (v) =>
                            setState(() => _isActive = v ?? true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            DeptDialogFooter(
              isEditing: _isEditing,
              isSaving: _isSaving,
              isDesignation: true,
              onCancel: () => Navigator.of(context).pop(),
              onSubmit: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
