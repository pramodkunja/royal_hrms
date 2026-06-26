import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import 'address_section.dart';
import 'branding_section.dart';
import 'contact_section.dart';
import 'legal_section.dart';

class CompanyInfoForm extends StatelessWidget {
  const CompanyInfoForm({
    super.key,
    required this.formKey,
    required this.nameCtrl,
    required this.tradeNameCtrl,
    required this.gstinCtrl,
    required this.cinCtrl,
    required this.panCtrl,
    required this.tanCtrl,
    required this.addressCtrl,
    required this.cityCtrl,
    required this.pinCtrl,
    required this.websiteCtrl,
    required this.phoneCtrl,
    required this.selectedState,
    required this.logoUrl,
    required this.logoBytes,
    required this.onStateChanged,
    required this.onLogoPicked,
    required this.onSave,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController tradeNameCtrl;
  final TextEditingController gstinCtrl;
  final TextEditingController cinCtrl;
  final TextEditingController panCtrl;
  final TextEditingController tanCtrl;
  final TextEditingController addressCtrl;
  final TextEditingController cityCtrl;
  final TextEditingController pinCtrl;
  final TextEditingController websiteCtrl;
  final TextEditingController phoneCtrl;
  final String? selectedState;
  final String? logoUrl;
  final Uint8List? logoBytes;
  final ValueChanged<String?> onStateChanged;
  final ValueChanged<Uint8List> onLogoPicked;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CompanyInfoHeader(),
            const SizedBox(height: 24),
            BrandingSection(
              logoUrl: logoUrl,
              logoBytes: logoBytes,
              onLogoPicked: onLogoPicked,
            ),
            const SizedBox(height: 20),
            LegalSection(
              nameController: nameCtrl,
              tradeNameController: tradeNameCtrl,
              gstinController: gstinCtrl,
              cinController: cinCtrl,
              panController: panCtrl,
              tanController: tanCtrl,
            ),
            const SizedBox(height: 20),
            AddressSection(
              addressController: addressCtrl,
              cityController: cityCtrl,
              pinController: pinCtrl,
              selectedState: selectedState,
              onStateChanged: onStateChanged,
            ),
            const SizedBox(height: 20),
            ContactSection(
              websiteController: websiteCtrl,
              phoneController: phoneCtrl,
            ),
            const SizedBox(height: 32),
            CompanyInfoFooter(onSave: onSave),
          ],
        ),
      ),
    );
  }
}

class _CompanyInfoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Company Information',
          style: context.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          'Legal entity details, statutory identifiers, and registered address',
          style: context.textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
          ),
        ),
      ],
    );
  }
}

class CompanyInfoFooter extends StatelessWidget {
  const CompanyInfoFooter({super.key, required this.onSave});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: onSave,
          icon: const Icon(Icons.check_circle_outline, size: 20),
          label: const Text(
            'Save Changes',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => Navigator.of(context).maybePop(),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            foregroundColor: colorScheme.onSurface,
            side: BorderSide(color: colorScheme.outlineVariant),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
