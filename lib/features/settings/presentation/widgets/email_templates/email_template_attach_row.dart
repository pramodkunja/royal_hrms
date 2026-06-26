import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../domain/entities/email_template.dart';

class EmailTemplateAttachFilesRow extends StatelessWidget {
  const EmailTemplateAttachFilesRow({
    super.key,
    required this.attachments,
    required this.pendingFiles,
    required this.onRemoveUploaded,
    required this.onRemovePending,
    required this.onPickFiles,
  });

  final List<EmailTemplateAttachment> attachments;
  final List<PlatformFile> pendingFiles;
  final ValueChanged<EmailTemplateAttachment> onRemoveUploaded;
  final ValueChanged<PlatformFile> onRemovePending;
  final VoidCallback onPickFiles;

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final mutedColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final chipBg =
        isDark ? AppColors.darkFieldFill : AppColors.lightFieldFill;
    final totalCount = attachments.length + pendingFiles.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: onPickFiles,
              icon: Icon(Icons.attach_file, size: 15, color: mutedColor),
              label: Text('Attach files', style: TextStyle(color: mutedColor)),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 38),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                side: BorderSide(color: borderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            if (totalCount > 0) ...[
              const SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...attachments.map(
                        (a) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _AttachmentChip(
                            label: '${a.filename} ${a.displaySize}',
                            background: chipBg,
                            borderColor: borderColor,
                            mutedColor: mutedColor,
                            onRemove: () => onRemoveUploaded(a),
                          ),
                        ),
                      ),
                      ...pendingFiles.map(
                        (f) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _AttachmentChip(
                            label: f.name,
                            background:
                                AppColors.warning.withValues(alpha: 0.12),
                            borderColor:
                                AppColors.warning.withValues(alpha: 0.45),
                            mutedColor: mutedColor,
                            onRemove: () => onRemovePending(f),
                            isPending: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$totalCount ${totalCount == 1 ? 'file' : 'files'}',
                style: context.textTheme.bodySmall?.copyWith(
                  color: mutedColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ] else ...[
              const SizedBox(width: 12),
              Text(
                'PDF, Word, Excel, images',
                style: context.textTheme.bodySmall?.copyWith(
                  color: mutedColor.withValues(alpha: 0.6),
                ),
              ),
            ],
          ],
        ),
        if (pendingFiles.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            'Pending files will be uploaded when you save.',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.warning,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }
}

class _AttachmentChip extends StatelessWidget {
  const _AttachmentChip({
    required this.label,
    required this.background,
    required this.borderColor,
    required this.mutedColor,
    required this.onRemove,
    this.isPending = false,
  });

  final String label;
  final Color background;
  final Color borderColor;
  final Color mutedColor;
  final VoidCallback onRemove;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPending
                ? Icons.upload_outlined
                : Icons.insert_drive_file_outlined,
            size: 13,
            color: isPending ? AppColors.warning : mutedColor,
          ),
          const SizedBox(width: 5),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 120),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isPending ? AppColors.warning : mutedColor,
                    fontSize: 11,
                  ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 13,
              color: isPending ? AppColors.warning : mutedColor,
            ),
          ),
        ],
      ),
    );
  }
}
