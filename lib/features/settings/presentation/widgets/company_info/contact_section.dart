import 'package:flutter/material.dart';

import 'section_card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.websiteController,
    required this.phoneController,
  });

  final TextEditingController websiteController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return SectionCard(
      icon: Icons.link_outlined,
      title: 'Contact',
      child: isMobile
          ? Column(
              children: [
                _WebsiteField(controller: websiteController),
                const SizedBox(height: 16),
                _PhoneField(controller: phoneController),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _WebsiteField(controller: websiteController)),
                const SizedBox(width: 16),
                Expanded(child: _PhoneField(controller: phoneController)),
              ],
            ),
    );
  }
}

class _WebsiteField extends StatelessWidget {
  const _WebsiteField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.url,
      decoration: const InputDecoration(
        labelText: 'Website',
        hintText: 'https://royalstaffing.in',
        prefixIcon: Icon(Icons.language_outlined),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Official Phone',
        hintText: '+91 88765 43210',
        prefixIcon: Icon(Icons.phone_outlined),
      ),
    );
  }
}
