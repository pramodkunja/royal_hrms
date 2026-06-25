import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/email_template.dart';
import 'settings_providers.dart';

// ---------------------------------------------------------------------------
// Per-category available tags (fallback when a template has no server variables)
// ---------------------------------------------------------------------------

const _availableTagsByCategory = <EmailTemplateCategory, List<String>>{
  EmailTemplateCategory.document: [
    '{FNAME}',
    '{LNAME}',
    '{FULL_NAME}',
    '{EMAIL}',
    '{EMPLOYEE_ID}',
    '{MONTH}',
    '{YEAR}',
    '{COMPANY}',
  ],
  EmailTemplateCategory.notification: [
    '{FNAME}',
    '{LNAME}',
    '{FULL_NAME}',
    '{EMAIL}',
    '{EMPLOYEE_ID}',
    '{COMPANY}',
  ],
  EmailTemplateCategory.reminder: [
    '{FULL_NAME}',
    '{FNAME}',
    '{DATE}',
    '{MANAGER}',
    '{COMPANY}',
    '{EMAIL}',
  ],
  EmailTemplateCategory.wish: [
    '{FNAME}',
    '{FULL_NAME}',
    '{YEARS}',
    '{COMPANY}',
    '{DATE}',
  ],
};

List<String> tagsForCategory(EmailTemplateCategory category) =>
    _availableTagsByCategory[category] ?? const [];

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class EmailTemplatesState {
  const EmailTemplatesState({required this.templates});

  final List<EmailTemplate> templates;

  List<EmailTemplate> byCategory(EmailTemplateCategory category) =>
      templates.where((t) => t.category == category).toList();

  List<EmailTemplate> search(String query) {
    if (query.trim().isEmpty) return templates;
    final q = query.toLowerCase();
    return templates
        .where(
          (t) =>
              t.name.toLowerCase().contains(q) ||
              t.subject.toLowerCase().contains(q) ||
              t.description.toLowerCase().contains(q),
        )
        .toList();
  }

  EmailTemplatesState copyWith({List<EmailTemplate>? templates}) =>
      EmailTemplatesState(templates: templates ?? this.templates);
}

// ---------------------------------------------------------------------------
// AsyncNotifier
// ---------------------------------------------------------------------------

class EmailTemplatesNotifier extends AsyncNotifier<EmailTemplatesState> {
  @override
  Future<EmailTemplatesState> build() async {
    final repo = ref.watch(settingsRepositoryProvider);
    final templates = await repo.getEmailTemplates();
    return EmailTemplatesState(templates: List.unmodifiable(templates));
  }

  /// Creates a new template via the API then appends it to local state.
  /// Returns the created template so callers can immediately act on the ID.
  Future<EmailTemplate> add(EmailTemplate template) async {
    final repo = ref.read(settingsRepositoryProvider);
    final created = await repo.createEmailTemplate(template);
    state = state.whenData((s) {
      final updated = List<EmailTemplate>.from(s.templates)..add(created);
      return s.copyWith(templates: List.unmodifiable(updated));
    });
    return created;
  }

  /// Updates an existing template via the API then replaces it in local state.
  Future<void> updateTemplate(EmailTemplate template) async {
    final repo = ref.read(settingsRepositoryProvider);
    final saved = await repo.updateEmailTemplate(template);
    state = state.whenData((s) {
      final updated =
          s.templates.map((t) => t.id == saved.id ? saved : t).toList();
      return s.copyWith(templates: List.unmodifiable(updated));
    });
  }

  /// Toggles is_active for a template via the API then updates local state.
  Future<void> toggleActive(String id, bool isActive) async {
    final repo = ref.read(settingsRepositoryProvider);
    final saved = await repo.toggleActiveEmailTemplate(id, isActive);
    state = state.whenData((s) {
      final updated =
          s.templates.map((t) => t.id == saved.id ? saved : t).toList();
      return s.copyWith(templates: List.unmodifiable(updated));
    });
  }

  /// Removes an attachment from a template and updates local state.
  Future<void> removeAttachment(String templateId, int attachmentId) async {
    final repo = ref.read(settingsRepositoryProvider);
    await repo.deleteEmailTemplateAttachment(templateId, attachmentId);
    state = state.whenData((s) {
      final updated = s.templates.map((t) {
        if (t.id != templateId) return t;
        final newAttachments =
            t.attachments.where((a) => a.id != attachmentId).toList();
        return t.copyWith(attachments: newAttachments);
      }).toList();
      return s.copyWith(templates: List.unmodifiable(updated));
    });
  }

  /// Uploads a file attachment to a template via the API then updates local state.
  Future<EmailTemplateAttachment> uploadAttachment(
    String templateId,
    String filename,
    Uint8List bytes,
  ) async {
    final repo = ref.read(settingsRepositoryProvider);
    final attachment = await repo.uploadEmailTemplateAttachment(
      templateId,
      filename,
      bytes,
    );
    state = state.whenData((s) {
      final updated = s.templates.map((t) {
        if (t.id != templateId) return t;
        return t.copyWith(attachments: [...t.attachments, attachment]);
      }).toList();
      return s.copyWith(templates: List.unmodifiable(updated));
    });
    return attachment;
  }

  /// Deletes a template via the API then removes it from local state.
  Future<void> delete(String id) async {
    final repo = ref.read(settingsRepositoryProvider);
    await repo.deleteEmailTemplate(id);
    state = state.whenData((s) {
      final updated = s.templates.where((t) => t.id != id).toList();
      return s.copyWith(templates: List.unmodifiable(updated));
    });
  }
}

final emailTemplatesProvider =
    AsyncNotifierProvider<EmailTemplatesNotifier, EmailTemplatesState>(
  EmailTemplatesNotifier.new,
);
