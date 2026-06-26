import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entities/smtp_config.dart';
import '../../providers/smtp_form_state.dart';
import '../../providers/smtp_settings_notifier.dart';
import 'smtp_form_body.dart';
import 'smtp_form_chrome.dart';

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
    _portController =
        TextEditingController(text: c != null ? c.port.toString() : '587');
    _senderNameController =
        TextEditingController(text: c?.senderName ?? '');
    _fromEmailController =
        TextEditingController(text: c?.fromEmail ?? '');
    _usernameController =
        TextEditingController(text: c?.username ?? '');
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

    return AlertDialog(
      backgroundColor: AppColors.lightSurface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      title: SmtpFormTitleBar(
        isEditing: _isEditing,
        onClose: () =>
            Navigator.of(context, rootNavigator: true).pop(),
      ),
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
                  SmtpFormErrorBanner(failure: formState.failure!),
                SmtpFormBody(
                  nameController: _nameController,
                  hostController: _hostController,
                  portController: _portController,
                  senderNameController: _senderNameController,
                  fromEmailController: _fromEmailController,
                  usernameController: _usernameController,
                  passwordController: _passwordController,
                  bccEmailController: _bccEmailController,
                  useTls: _useTls,
                  priority: _priority,
                  receiverEmail: _receiverEmail,
                  obscurePassword: _obscurePassword,
                  isEditing: _isEditing,
                  onSetUseTls: (v) => setState(() => _useTls = v),
                  onSetPriority: (v) => setState(() => _priority = v),
                  onSetReceiverEmail: (v) =>
                      setState(() => _receiverEmail = v),
                  onTogglePassword: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        SmtpFormFooter(
          isEditing: _isEditing,
          isSubmitting: isSubmitting,
          onSubmit: _submit,
          onCancel: () =>
              Navigator.of(context, rootNavigator: true).pop(),
        ),
      ],
    );
  }
}
