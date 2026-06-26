import 'package:flutter/material.dart';

import 'section_card.dart';

const _kIndiaStates = [
  'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
  'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka',
  'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya',
  'Mizoram', 'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim',
  'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand',
  'West Bengal', 'Andaman and Nicobar Islands', 'Chandigarh',
  'Dadra and Nagar Haveli and Daman and Diu', 'Delhi',
  'Jammu and Kashmir', 'Ladakh', 'Lakshadweep', 'Puducherry',
];

class AddressSection extends StatelessWidget {
  const AddressSection({
    super.key,
    required this.addressController,
    required this.cityController,
    required this.pinController,
    required this.selectedState,
    required this.onStateChanged,
  });

  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController pinController;
  final String? selectedState;
  final ValueChanged<String?> onStateChanged;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return SectionCard(
      icon: Icons.location_on_outlined,
      title: 'Registered Address',
      child: Column(
        children: [
          TextFormField(
            controller: addressController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Address *',
              alignLabelWithHint: true,
              hintText: 'Street address, building, floor...',
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Address is required' : null,
          ),
          const SizedBox(height: 16),
          isMobile
              ? _MobileRow(
                  cityController: cityController,
                  pinController: pinController,
                  selectedState: selectedState,
                  onStateChanged: onStateChanged,
                )
              : _DesktopRow(
                  cityController: cityController,
                  pinController: pinController,
                  selectedState: selectedState,
                  onStateChanged: onStateChanged,
                ),
        ],
      ),
    );
  }
}

class _DesktopRow extends StatelessWidget {
  const _DesktopRow({
    required this.cityController,
    required this.pinController,
    required this.selectedState,
    required this.onStateChanged,
  });

  final TextEditingController cityController;
  final TextEditingController pinController;
  final String? selectedState;
  final ValueChanged<String?> onStateChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              labelText: 'City *',
              hintText: 'Mumbai',
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'City is required' : null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StateDropdown(
            value: selectedState,
            onChanged: onStateChanged,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: pinController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: const InputDecoration(
              labelText: 'PIN Code *',
              hintText: '400001',
              counterText: '',
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'PIN Code is required';
              if (v.trim().length != 6) return 'Enter a valid 6-digit PIN';
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class _MobileRow extends StatelessWidget {
  const _MobileRow({
    required this.cityController,
    required this.pinController,
    required this.selectedState,
    required this.onStateChanged,
  });

  final TextEditingController cityController;
  final TextEditingController pinController;
  final String? selectedState;
  final ValueChanged<String?> onStateChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: cityController,
          decoration: const InputDecoration(labelText: 'City *'),
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'City is required' : null,
        ),
        const SizedBox(height: 16),
        _StateDropdown(value: selectedState, onChanged: onStateChanged),
        const SizedBox(height: 16),
        TextFormField(
          controller: pinController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: const InputDecoration(
            labelText: 'PIN Code *',
            counterText: '',
          ),
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'PIN Code is required';
            if (v.trim().length != 6) return 'Enter a valid 6-digit PIN';
            return null;
          },
        ),
      ],
    );
  }
}

class _StateDropdown extends StatelessWidget {
  const _StateDropdown({required this.value, required this.onChanged});

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final current = _kIndiaStates.contains(value) ? value : null;
    return DropdownButtonFormField<String>(
      key: ValueKey(current),
      initialValue: current,
      isExpanded: true,
      decoration: const InputDecoration(labelText: 'State / UT *'),
      items: _kIndiaStates
          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
          .toList(),
      onChanged: onChanged,
      validator: (v) =>
          (v == null || v.isEmpty) ? 'State is required' : null,
    );
  }
}
