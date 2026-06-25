import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/smtp_config.dart';
import '../providers/smtp_form_state.dart';
import '../providers/smtp_settings_notifier.dart';

class SmtpFormDialog extends ConsumerStatefulWidget {
  const SmtpFormDialog({super.key, this.existingConfig});

  final SmtpConfig? existingConfig;

  @override
  ConsumerState<SmtpFormDialog> createState() => _SmtpFormDialogState();
}

class _SmtpFormDialogState extends ConsumerState<SmtpFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _hostController;
  late final TextEditingController _portController;
  late final TextEditingController _senderNameController;
  late final TextEditingController _fromEmailController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _bccEmailController;

  late bool _useTls;
  late SmtpPriority _priority;
  late SmtpReceiverEmail _receiverEmail;
  bool _obscurePassword = true;

  bool get _isEditing => widget.existingConfig != null;

  @override
  void initState() {
    super.initState();
    final c = widget.existingConfig;
    _useTls = c?.useTls ?? true;
    _priority = c?.priority ?? SmtpPriority.normal;
    _receiverEmail = c?.receiverEmail ?? SmtpReceiverEmail.emailId;

    _nameController = TextEditingController(text: c?.name ?? '');
    _hostController = TextEditingController(text: c?.host ?? '');
    _portController = TextEditingController(
      text: c != null ? c.port.toString() : '587',
    );
    _senderNameController = TextEditingController(text: c?.senderName ?? '');
    _fromEmailController = TextEditingController(text: c?.fromEmail ?? '');
    _usernameController = TextEditingController(text: c?.username ?? '');
    _passwordController = TextEditingController();
    _bccEmailController = TextEditingController(text: c?.bccEmail ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hostController.dispose();
    _portController.dispose();
    _senderNameController.dispose();
    _fromEmailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _bccEmailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final data = <String, dynamic>{
      'name': _nameController.text.trim(),
      'smtp_type': SmtpType.local.name,
      'host': _hostController.text.trim(),
      'port': int.tryParse(_portController.text.trim()) ?? 587,
      'use_tls': _useTls,
      'sender_name': _senderNameController.text.trim(),
      'from_email': _fromEmailController.text.trim(),
      'username': _usernameController.text.trim(),
      'password': _passwordController.text,
      'bcc_email': _bccEmailController.text.trim().isEmpty
          ? null
          : _bccEmailController.text.trim(),
      'priority': _priority.name,
      'receiver_email_type': _receiverEmail == SmtpReceiverEmail.emailId
          ? 'email_id'
          : 'personal_email_id',
    };

    final notifier = ref.read(smtpFormNotifierProvider.notifier);
    if (_isEditing) {
      await notifier.updateSmtpConfig(widget.existingConfig!.id, data);
    } else {
      await notifier.createSmtpConfig(data);
    }

    if (!mounted) return;

    final formState = ref.read(smtpFormNotifierProvider);
    if (formState.status == SmtpFormStatus.success) {
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'SMTP configuration updated successfully'
                : 'SMTP configuration added successfully',
          ),
        ),
      );
      notifier.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(smtpFormNotifierProvider);
    final isSubmitting = formState.status == SmtpFormStatus.submitting;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      backgroundColor: AppColors.lightSurface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      title: _buildTitleBar(textTheme),
      content: SizedBox(
        width: 640,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (formState.status == SmtpFormStatus.failure &&
                    formState.failure != null)
                  _buildErrorBanner(formState.failure!),
                _buildFormBody(context, textTheme),
              ],
            ),
          ),
        ),
      ),
      actions: [_buildFooter(context, isSubmitting)],
    );
  }

  Widget _buildTitleBar(TextTheme textTheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 12, 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _isEditing
                      ? 'Edit SMTP Configuration'
                      : 'Add SMTP Configuration',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightOnSurface,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                color: AppColors.lightTextMuted,
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.lightBorder),
      ],
    );
  }

  Widget _buildFormBody(BuildContext context, TextTheme textTheme) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final isWide = constraints.maxWidth > 480;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Configuration Name — full width
            _label('Configuration Name', required: true),
            _field(
              controller: _nameController,
              hint: 'e.g. Gmail SMTP, Corporate Mail',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            _gap(),

            // SMTP Host | Port + TLS
            _row(
              isWide: isWide,
              left: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('SMTP Host', required: true),
                  _field(
                    controller: _hostController,
                    hint: 'smtp.gmail.com',
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Host is required' : null,
                  ),
                ],
              ),
              right: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Port'),
                  Row(
                    children: [
                      Expanded(
                        child: _field(
                          controller: _portController,
                          hint: '587',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: _useTls,
                            activeColor: AppColors.primary,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (v) =>
                                setState(() => _useTls = v ?? true),
                          ),
                          Text(
                            'TLS',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.lightOnSurface),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _gap(),

            // Sender Name | From Email
            _row(
              isWide: isWide,
              left: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Sender Name'),
                  _field(
                    controller: _senderNameController,
                    hint: 'Royal HRMS',
                  ),
                ],
              ),
              right: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('From Email', required: true),
                  _field(
                    controller: _fromEmailController,
                    hint: 'you@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Email required';
                      if (!v.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                ],
              ),
            ),
            _gap(),

            // Username | Password
            _row(
              isWide: isWide,
              left: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Username', required: true),
                  _field(
                    controller: _usernameController,
                    hint: 'login username / email',
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Username is required'
                        : null,
                  ),
                ],
              ),
              right: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Password', required: !_isEditing),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: AppColors.lightOnSurface),
                    decoration: _decoration('SMTP password / App password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 18,
                          color: AppColors.lightTextMuted,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    validator: (v) {
                      if (!_isEditing && (v == null || v.isEmpty)) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            _gap(),

            // BCC Email | Priority
            _row(
              isWide: isWide,
              left: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('BCC Email'),
                  _field(
                    controller: _bccEmailController,
                    hint: 'bcc@company.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
              right: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Priority'),
                  // ignore: deprecated_member_use
                  DropdownButtonFormField<SmtpPriority>(
                    // ignore: deprecated_member_use
                    value: _priority,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: AppColors.lightOnSurface),
                    decoration: _decoration('Select priority'),
                    items: const [
                      DropdownMenuItem(
                        value: SmtpPriority.normal,
                        child: Text('Normal'),
                      ),
                      DropdownMenuItem(
                        value: SmtpPriority.high,
                        child: Text('High'),
                      ),
                    ],
                    onChanged: (v) {
                      if (v != null) setState(() => _priority = v);
                    },
                  ),
                ],
              ),
            ),
            _gap(),

            // Receivers Email
            _label('Receivers Email'),
            const SizedBox(height: 4),
            Row(
              children: [
                _radioTile(SmtpReceiverEmail.emailId, 'Email ID', context),
                const SizedBox(width: 20),
                _radioTile(
                    SmtpReceiverEmail.personalEmailId, 'Personal Email ID', context),
              ],
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  Widget _buildErrorBanner(Failure failure) {
    final message = switch (failure) {
      ServerFailure(:final message) => message,
      NetworkFailure(:final message) => message,
      UnauthorizedFailure(:final message) => message,
      ValidationFailure(:final message) => message,
      CacheFailure(:final message) => message,
      UnknownFailure(:final message) => message,
    };
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.error, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.error,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isSubmitting) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.lightBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: OverflowBar(
        alignment: MainAxisAlignment.end,
        spacing: 8,
        overflowAlignment: OverflowBarAlignment.end,
        overflowSpacing: 8,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.lightTextMuted,
              minimumSize: const Size(0, 40),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: isSubmitting
                ? null
                : () => Navigator.of(context, rootNavigator: true).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, 40),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: isSubmitting ? null : _submit,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSubmitting)
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                else
                  const Icon(Icons.save_outlined, size: 16),
                const SizedBox(width: 6),
                Text(_isEditing ? 'Save' : 'Add Configuration'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── helpers ────────────────────────────────────────────────────────────────

  Widget _label(String text, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          text: text,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.lightOnSurface,
                fontWeight: FontWeight.w600,
              ),
          children: required
              ? const [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: AppColors.error),
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.lightOnSurface,
          ),
      decoration: _decoration(hint),
      validator: validator,
    );
  }

  Widget _row({
    required bool isWide,
    required Widget left,
    required Widget right,
  }) {
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: left),
          const SizedBox(width: 16),
          Expanded(child: right),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [left, const SizedBox(height: 16), right],
    );
  }

  Widget _radioTile(SmtpReceiverEmail value, String label, BuildContext ctx) {
    return GestureDetector(
      onTap: () => setState(() => _receiverEmail = value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ignore: deprecated_member_use
          Radio<SmtpReceiverEmail>(
            value: value,
            // ignore: deprecated_member_use
            groupValue: _receiverEmail,
            activeColor: AppColors.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // ignore: deprecated_member_use
            onChanged: (v) {
              if (v != null) setState(() => _receiverEmail = v);
            },
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style:
                Theme.of(ctx).textTheme.bodySmall?.copyWith(
              color: AppColors.lightOnSurface,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _gap() => const SizedBox(height: 16);

  InputDecoration _decoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle:
            const TextStyle(color: AppColors.lightTextMuted, fontSize: 13),
        filled: true,
        fillColor: AppColors.lightFieldFill,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      );
}
