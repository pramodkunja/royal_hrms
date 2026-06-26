import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_loader.dart';
import '../../../domain/entities/company_info.dart';
import '../../providers/company_info_providers.dart';
import '../../widgets/company_info/company_info_form.dart';

class CompanyInfoPage extends ConsumerStatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  ConsumerState<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends ConsumerState<CompanyInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _tradeNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _cinCtrl = TextEditingController();
  final _panCtrl = TextEditingController();
  final _tanCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  final _websiteCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String? _selectedState;
  Uint8List? _logoBytes;
  bool _initialized = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _tradeNameCtrl.dispose();
    _gstinCtrl.dispose();
    _cinCtrl.dispose();
    _panCtrl.dispose();
    _tanCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _pinCtrl.dispose();
    _websiteCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _populate(CompanyInfo info) {
    _nameCtrl.text = info.name;
    _tradeNameCtrl.text = info.tradeName;
    _gstinCtrl.text = info.gstin;
    _cinCtrl.text = info.cin;
    _panCtrl.text = info.pan;
    _tanCtrl.text = info.tan;
    _addressCtrl.text = info.address;
    _cityCtrl.text = info.city;
    _pinCtrl.text = info.pinCode;
    _websiteCtrl.text = info.website;
    _phoneCtrl.text = info.phone;
    _selectedState = info.state.isEmpty ? null : info.state;
  }

  CompanyInfo _fromForm(int? existingId, String? logoUrl) {
    return CompanyInfo(
      id: existingId,
      name: _nameCtrl.text.trim(),
      tradeName: _tradeNameCtrl.text.trim(),
      gstin: _gstinCtrl.text.trim(),
      cin: _cinCtrl.text.trim(),
      pan: _panCtrl.text.trim(),
      tan: _tanCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
      city: _cityCtrl.text.trim(),
      state: _selectedState ?? '',
      pinCode: _pinCtrl.text.trim(),
      website: _websiteCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      logoUrl: logoUrl,
    );
  }

  Future<void> _save(CompanyInfo current) async {
    if (!_formKey.currentState!.validate()) return;
    final updated = _fromForm(current.id, current.logoUrl);
    final ok = await ref
        .read(companyInfoProvider.notifier)
        .save(updated, logoBytes: _logoBytes);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? 'Saved successfully.' : 'Failed to save.'),
        backgroundColor: ok ? AppColors.success : AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncInfo = ref.watch(companyInfoProvider);

    ref.listen<AsyncValue<CompanyInfo>>(companyInfoProvider, (_, next) {
      if (_initialized) return;
      next.whenData((info) {
        _populate(info);
        setState(() => _initialized = true);
      });
    });

    if (!_initialized && asyncInfo.hasValue) {
      _populate(asyncInfo.requireValue);
      _initialized = true;
    }

    return Scaffold(
      appBar: const _AppBar(),
      body: asyncInfo.when(
        loading: () => const AppLoader(),
        error: (e, _) => _ErrorBody(
          message: e.toString(),
          onRetry: () => ref.invalidate(companyInfoProvider),
        ),
        data: (info) => CompanyInfoForm(
          formKey: _formKey,
          nameCtrl: _nameCtrl,
          tradeNameCtrl: _tradeNameCtrl,
          gstinCtrl: _gstinCtrl,
          cinCtrl: _cinCtrl,
          panCtrl: _panCtrl,
          tanCtrl: _tanCtrl,
          addressCtrl: _addressCtrl,
          cityCtrl: _cityCtrl,
          pinCtrl: _pinCtrl,
          websiteCtrl: _websiteCtrl,
          phoneCtrl: _phoneCtrl,
          selectedState: _selectedState,
          logoUrl: info.logoUrl,
          logoBytes: _logoBytes,
          onStateChanged: (v) => setState(() => _selectedState = v),
          onLogoPicked: (bytes) => setState(() => _logoBytes = bytes),
          onSave: () => _save(info),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
      title: const Text('Company Information'),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 12),
            Text(message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
