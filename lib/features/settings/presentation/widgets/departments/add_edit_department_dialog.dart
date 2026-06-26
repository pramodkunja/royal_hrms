import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../domain/entities/department.dart';
import '../../providers/departments_providers.dart';
import 'department_dialog_chrome.dart';
import 'department_dialog_shared_widgets.dart';

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
            DeptDialogHeader(
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
                        DeptDialogErrorBanner(
                          message: _errorMessage!,
                          onDismiss: _clearError,
                        ),
                        const SizedBox(height: 16),
                      ],
                      const DeptDialogFieldLabel(
                        label: 'Department Name',
                        required: true,
                      ),
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
                      const DeptDialogDescriptionLabel(),
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
              onCancel: () => Navigator.of(context).pop(),
              onSubmit: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
