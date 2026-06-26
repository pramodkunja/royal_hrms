import 'package:flutter/material.dart';

import 'section_card.dart';

class LegalSection extends StatelessWidget {
  const LegalSection({
    super.key,
    required this.nameController,
    required this.tradeNameController,
    required this.gstinController,
    required this.cinController,
    required this.panController,
    required this.tanController,
  });

  final TextEditingController nameController;
  final TextEditingController tradeNameController;
  final TextEditingController gstinController;
  final TextEditingController cinController;
  final TextEditingController panController;
  final TextEditingController tanController;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      icon: Icons.balance_outlined,
      title: 'Legal & Statutory',
      child: Column(
        children: [
          _FieldRow(
            left: _LegalField(
              label: 'Company Name',
              required: true,
              controller: nameController,
              hint: 'Registered company name',
            ),
            right: _LegalField(
              label: 'Trade Name',
              controller: tradeNameController,
              hint: 'DBA or brand name (optional)',
            ),
          ),
          const SizedBox(height: 16),
          _FieldRow(
            left: _LegalField(
              label: 'GSTIN',
              required: true,
              controller: gstinController,
              hint: '22AAAAA0000A1Z5',
            ),
            right: _LegalField(
              label: 'CIN',
              required: true,
              controller: cinController,
              hint: 'U74999MH2020PTC123458',
            ),
          ),
          const SizedBox(height: 16),
          _FieldRow(
            left: _LegalField(
              label: 'PAN',
              required: true,
              controller: panController,
              hint: 'AAAAA0000A',
            ),
            right: _LegalField(
              label: 'TAN',
              required: true,
              controller: tanController,
              hint: 'PNEA12345B',
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({required this.left, required this.right});

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < 600) {
      return Column(
        children: [left, const SizedBox(height: 16), right],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: 16),
        Expanded(child: right),
      ],
    );
  }
}

class _LegalField extends StatelessWidget {
  const _LegalField({
    required this.label,
    required this.controller,
    this.hint,
    this.required = false,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        hintText: hint,
      ),
      validator: required
          ? (v) =>
              (v == null || v.trim().isEmpty) ? '$label is required' : null
          : null,
    );
  }
}
