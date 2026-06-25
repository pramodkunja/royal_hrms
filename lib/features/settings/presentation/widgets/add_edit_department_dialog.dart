import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/department.dart';
import '../providers/departments_providers.dart';

// ---------------------------------------------------------------------------
// Add / Edit Department Dialog
// ---------------------------------------------------------------------------

class AddEditDepartmentDialog extends ConsumerStatefulWidget {
  const AddEditDepartmentDialog({super.key, this.existing});

  final Department? existing;

  static Future<void> show(BuildContext context, {Department? existing}) {
    return showDialog(
      context: context,
      builder: (_) => AddEditDepartmentDialog(existing: existing),
    );
  }

  @override
  ConsumerState<AddEditDepartmentDialog> createState() =>
      _AddEditDepartmentDialogState();
}

class _AddEditDepartmentDialogState
    extends ConsumerState<AddEditDepartmentDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descriptionCtrl;
  late bool _isActive;
  bool _isSaving = false;
  String? _errorMessage;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final dept = widget.existing;
    _nameCtrl = TextEditingController(text: dept?.name ?? '');
    _descriptionCtrl = TextEditingController(text: dept?.description ?? '');
    _isActive = dept?.isActive ?? true;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
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
      final dept = Department(
        id: widget.existing?.id ?? '',
        name: _nameCtrl.text.trim(),
        description: _descriptionCtrl.text.trim(),
        isActive: _isActive,
        designations: widget.existing?.designations ?? const [],
      );

      if (_isEditing) {
        await ref.read(departmentsProvider.notifier).updateDepartment(dept);
      } else {
        await ref.read(departmentsProvider.notifier).addDepartment(dept);
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

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: isMobile
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 24)
          : const EdgeInsets.symmetric(horizontal: 80, vertical: 48),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DeptDialogHeader(
              existing: widget.existing,
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
                        _DeptErrorBanner(
                          message: _errorMessage!,
                          onDismiss: _clearError,
                        ),
                        const SizedBox(height: 16),
                      ],
                      _DeptFieldLabel(label: 'Department Name', required: true),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameCtrl,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'e.g. Engineering',
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Department name is required'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      _DescriptionLabel(),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _descriptionCtrl,
                        minLines: 3,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: 'What does this department do?',
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _ActiveCheckboxRow(
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
            _DeptDialogFooter(
              isEditing: _isEditing,
              isSaving: _isSaving,
              onCancel: () => Navigator.of(context).pop(),
              onSubmit: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Add / Edit Designation Dialog
// ---------------------------------------------------------------------------

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
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

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
            _DesigDialogHeader(
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
                        _DeptErrorBanner(
                          message: _errorMessage!,
                          onDismiss: _clearError,
                        ),
                        const SizedBox(height: 16),
                      ],
                      // Department info chip
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
                      _DeptFieldLabel(
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
                      _ActiveCheckboxRow(
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
            _DeptDialogFooter(
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

// ---------------------------------------------------------------------------
// Shared sub-widgets
// ---------------------------------------------------------------------------

class _DeptErrorBanner extends StatelessWidget {
  const _DeptErrorBanner({required this.message, required this.onDismiss});

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;
    final errorContainerColor = Theme.of(context).colorScheme.errorContainer;
    final onErrorContainerColor =
        Theme.of(context).colorScheme.onErrorContainer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: errorContainerColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: errorColor.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(Icons.error_outline, size: 18, color: errorColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: onErrorContainerColor,
                fontWeight: FontWeight.w500,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onDismiss,
            child: Icon(Icons.close, size: 16, color: errorColor),
          ),
        ],
      ),
    );
  }
}

class _DeptFieldLabel extends StatelessWidget {
  const _DeptFieldLabel({required this.label, this.required = false});

  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    return RichText(
      text: TextSpan(
        text: label,
        style: context.textTheme.labelMedium?.copyWith(
          color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
          fontWeight: FontWeight.w500,
        ),
        children: required
            ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ]
            : null,
      ),
    );
  }
}

class _DescriptionLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Row(
      children: [
        Text(
          'Description',
          style: context.textTheme.labelMedium?.copyWith(
            color: isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '(optional)',
          style: context.textTheme.labelSmall?.copyWith(color: mutedColor),
        ),
      ],
    );
  }
}

class _ActiveCheckboxRow extends StatelessWidget {
  const _ActiveCheckboxRow({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Text(
            'Active',
            style: context.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _DeptDialogHeader extends StatelessWidget {
  const _DeptDialogHeader({
    required this.existing,
    required this.onClose,
  });

  final Department? existing;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final isEditing = existing != null;
    final isDark = context.theme.brightness == Brightness.dark;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 18, 16, 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEditing ? 'Edit: ${existing!.name}' : 'New Department',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isEditing) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Update department details',
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: mutedColor),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close),
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }
}

class _DesigDialogHeader extends StatelessWidget {
  const _DesigDialogHeader({
    required this.isEditing,
    required this.onClose,
  });

  final bool isEditing;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.badge_outlined,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isEditing ? 'Edit Designation' : 'Add Designation',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close),
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }
}

class _DeptDialogFooter extends StatelessWidget {
  const _DeptDialogFooter({
    required this.isEditing,
    required this.isSaving,
    required this.onCancel,
    required this.onSubmit,
    this.isDesignation = false,
  });

  final bool isEditing;
  final bool isSaving;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final bool isDesignation;

  String get _submitLabel {
    if (isEditing) return 'Save Changes';
    return isDesignation ? 'Add Designation' : 'Create Department';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: isSaving ? null : onCancel,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 12),
          FilledButton(
            onPressed: isSaving ? null : onSubmit,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(_submitLabel),
          ),
        ],
      ),
    );
  }
}
