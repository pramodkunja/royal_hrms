import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import 'section_card.dart';

class BrandingSection extends StatelessWidget {
  const BrandingSection({
    super.key,
    required this.logoUrl,
    required this.logoBytes,
    required this.onLogoPicked,
  });

  final String? logoUrl;
  final Uint8List? logoBytes;
  final ValueChanged<Uint8List> onLogoPicked;

  Future<void> _pickLogo(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'svg'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final bytes = result.files.first.bytes;
    if (bytes == null) return;
    if (bytes.lengthInBytes > 5 * 1024 * 1024) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File exceeds 5 MB limit.')),
      );
      return;
    }
    onLogoPicked(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      icon: Icons.business_outlined,
      title: 'Branding',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LogoPreview(logoUrl: logoUrl, logoBytes: logoBytes),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Company Logo',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'JPEG, PNG, WebP or SVG · Max 5 MB',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.theme.brightness == Brightness.dark
                        ? AppColors.darkTextMuted
                        : AppColors.lightTextMuted,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => _pickLogo(context),
                  icon: const Icon(Icons.upload_outlined, size: 18),
                  label: const Text('Upload'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoPreview extends StatelessWidget {
  const _LogoPreview({this.logoUrl, this.logoBytes});

  final String? logoUrl;
  final Uint8List? logoBytes;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    Widget content;
    if (logoBytes != null) {
      content = Image.memory(logoBytes!, fit: BoxFit.contain);
    } else if (logoUrl != null && logoUrl!.isNotEmpty) {
      content = Image.network(logoUrl!, fit: BoxFit.contain);
    } else {
      content = Icon(
        Icons.business_outlined,
        size: 40,
        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
      );
    }
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: content,
      ),
    );
  }
}
