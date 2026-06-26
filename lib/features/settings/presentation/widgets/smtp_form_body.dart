import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/smtp_config.dart';

class SmtpFormBody extends StatelessWidget {
  const SmtpFormBody({
    super.key,
    required this.nameController,
    required this.hostController,
    required this.portController,
    required this.senderNameController,
    required this.fromEmailController,
    required this.usernameController,
    required this.passwordController,
    required this.bccEmailController,
    required this.useTls,
    required this.priority,
    required this.receiverEmail,
    required this.obscurePassword,
    required this.isEditing,
    required this.onSetUseTls,
    required this.onSetPriority,
    required this.onSetReceiverEmail,
    required this.onTogglePassword,
  });

  final TextEditingController nameController;
  final TextEditingController hostController;
  final TextEditingController portController;
  final TextEditingController senderNameController;
  final TextEditingController fromEmailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController bccEmailController;
  final bool useTls;
  final SmtpPriority priority;
  final SmtpReceiverEmail receiverEmail;
  final bool obscurePassword;
  final bool isEditing;
  final ValueChanged<bool> onSetUseTls;
  final ValueChanged<SmtpPriority> onSetPriority;
  final ValueChanged<SmtpReceiverEmail> onSetReceiverEmail;
  final VoidCallback onTogglePassword;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final isWide = constraints.maxWidth > 480;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label(context, 'Configuration Name', required: true),
            _field(
              context,
              controller: nameController,
              hint: 'e.g. Gmail SMTP, Corporate Mail',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            _gap(),
            _row(
              isWide: isWide,
              left: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(context, 'SMTP Host', required: true),
                  _field(
                    context,
                    controller: hostController,
                    hint: 'smtp.gmail.com',
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Host is required'
                        : null,
                  ),
                ],
              ),
              right: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(context, 'Port'),
                  Row(
                    children: [
                      Expanded(
                        child: _field(
                          context,
                          controller: portController,
                          hint: '587',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: useTls,
                            activeColor: AppColors.primary,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (v) => onSetUseTls(v ?? true),
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
            _row(
              isWide: isWide,
              left: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(context, 'Sender Name'),
                  _field(context,
                      controller: senderNameController, hint: 'Royal HRMS'),
                ],
              ),
              right: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(context, 'From Email', required: true),
                  _field(
                    context,
                    controller: fromEmailController,
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
            _row(
              isWide: isWide,
              left: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(context, 'Username', required: true),
                  _field(
                    context,
                    controller: usernameController,
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
                  _label(context, 'Password', required: !isEditing),
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: AppColors.lightOnSurface),
                    decoration: _decoration('SMTP password / App password')
                        .copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 18,
                          color: AppColors.lightTextMuted,
                        ),
                        onPressed: onTogglePassword,
                      ),
                    ),
                    validator: (v) {
                      if (!isEditing && (v == null || v.isEmpty)) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            _gap(),
            _row(
              isWide: isWide,
              left: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(context, 'BCC Email'),
                  _field(
                    context,
                    controller: bccEmailController,
                    hint: 'bcc@company.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
              right: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(context, 'Priority'),
                  // ignore: deprecated_member_use
                  DropdownButtonFormField<SmtpPriority>(
                    // ignore: deprecated_member_use
                    value: priority,
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
                      if (v != null) onSetPriority(v);
                    },
                  ),
                ],
              ),
            ),
            _gap(),
            _label(context, 'Receivers Email'),
            const SizedBox(height: 4),
            Row(
              children: [
                _radioTile(
                  context,
                  SmtpReceiverEmail.emailId,
                  'Email ID',
                  receiverEmail,
                  onSetReceiverEmail,
                ),
                const SizedBox(width: 20),
                _radioTile(
                  context,
                  SmtpReceiverEmail.personalEmailId,
                  'Personal Email ID',
                  receiverEmail,
                  onSetReceiverEmail,
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  static Widget _label(
    BuildContext context,
    String text, {
    bool required = false,
  }) {
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

  static Widget _field(
    BuildContext context, {
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

  static Widget _row({
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

  static Widget _radioTile(
    BuildContext context,
    SmtpReceiverEmail value,
    String label,
    SmtpReceiverEmail groupValue,
    ValueChanged<SmtpReceiverEmail> onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ignore: deprecated_member_use
          Radio<SmtpReceiverEmail>(
            value: value,
            // ignore: deprecated_member_use
            groupValue: groupValue,
            activeColor: AppColors.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // ignore: deprecated_member_use
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.lightOnSurface,
                ),
          ),
        ],
      ),
    );
  }

  static SizedBox _gap() => const SizedBox(height: 16);

  static InputDecoration _decoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
            color: AppColors.lightTextMuted, fontSize: 13),
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
