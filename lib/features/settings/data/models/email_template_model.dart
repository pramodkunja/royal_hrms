import '../../domain/entities/email_template.dart';

class EmailTemplateAttachmentModel {
  const EmailTemplateAttachmentModel({
    required this.id,
    required this.filename,
    required this.mimeType,
    required this.sizeBytes,
    required this.url,
    required this.uploadedAt,
  });

  final int id;
  final String filename;
  final String mimeType;
  final int sizeBytes;
  final String url;
  final String uploadedAt;

  factory EmailTemplateAttachmentModel.fromJson(Map<String, dynamic> json) {
    return EmailTemplateAttachmentModel(
      id: (json['id'] as num).toInt(),
      filename: json['filename'] as String? ?? '',
      mimeType: json['mime_type'] as String? ?? '',
      sizeBytes: (json['size'] as num?)?.toInt() ?? 0,
      url: json['url'] as String? ?? '',
      uploadedAt: json['uploaded_at'] as String? ?? '',
    );
  }

  EmailTemplateAttachment toEntity() {
    return EmailTemplateAttachment(
      id: id,
      filename: filename,
      mimeType: mimeType,
      sizeBytes: sizeBytes,
      url: url,
      uploadedAt: DateTime.tryParse(uploadedAt) ?? DateTime.now(),
    );
  }
}

/// Wire-format representation of an email template from the API.
/// Lives exclusively in the data layer — never passes into presentation.
/// [toEntity] converts it to the domain [EmailTemplate].
class EmailTemplateModel {
  const EmailTemplateModel({
    required this.id,
    required this.name,
    required this.displayName,
    required this.description,
    required this.templateType,
    required this.subject,
    required this.body,
    required this.isActive,
    required this.isBuiltin,
    required this.availableVariables,
    required this.attachments,
    this.updatedAt,
  });

  final int id;
  final String name;             // slug identifier (snake_case)
  final String displayName;      // human-readable name
  final String description;
  final String templateType;     // "wish" | "reminder" | "notification" | "document"
  final String subject;
  final String body;
  final bool isActive;
  final bool isBuiltin;

  /// Variable names stored WITH braces ("{FULL_NAME}") to match the UI tag format.
  /// Braces are stripped when sending to the API via [toCreateJson]/[toUpdateJson].
  final List<String> availableVariables;
  final List<EmailTemplateAttachmentModel> attachments;
  final String? updatedAt;

  factory EmailTemplateModel.fromJson(Map<String, dynamic> json) {
    final rawVars = json['available_variables'];
    final vars = (rawVars is List)
        ? rawVars.map((e) => '{${e.toString()}}').toList()
        : <String>[];

    final rawAttachments = json['attachments'];
    final attachments = (rawAttachments is List)
        ? rawAttachments
            .whereType<Map<String, dynamic>>()
            .map(EmailTemplateAttachmentModel.fromJson)
            .toList()
        : <EmailTemplateAttachmentModel>[];

    return EmailTemplateModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      displayName: json['display_name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      templateType: json['template_type'] as String? ?? '',
      subject: json['subject'] as String? ?? '',
      body: json['body'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      isBuiltin: json['is_builtin'] as bool? ?? false,
      availableVariables: vars,
      attachments: attachments,
      updatedAt: json['updated_at'] as String?,
    );
  }

  /// JSON for POST /settings/email-templates/ (create).
  Map<String, dynamic> toCreateJson() => {
    'name': name,
    'display_name': displayName,
    'description': description,
    'template_type': templateType,
    'subject': subject,
    'body': body,
    'is_active': isActive,
    'available_variables': _stripBraces(availableVariables),
  };

  /// JSON for PATCH /settings/email-templates/{id}/ (partial update).
  Map<String, dynamic> toUpdateJson() => {
    'subject': subject,
    'body': body,
    'is_active': isActive,
    'available_variables': _stripBraces(availableVariables),
  };

  /// JSON for PATCH when only toggling is_active.
  static Map<String, dynamic> toToggleJson(bool isActive) => {
    'is_active': isActive,
  };

  EmailTemplate toEntity() {
    return EmailTemplate(
      id: id.toString(),
      name: displayName,
      slug: name,
      category: _categoryFromString(templateType),
      subject: subject,
      body: body,
      description: description,
      isBuiltIn: isBuiltin,
      isActive: isActive,
      availableVariables: availableVariables,
      attachments: attachments.map((a) => a.toEntity()).toList(),
      lastUpdatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
    );
  }

  static EmailTemplateModel fromEntity(EmailTemplate entity) {
    return EmailTemplateModel(
      id: int.tryParse(entity.id) ?? 0,
      name: entity.slug,
      displayName: entity.name,
      description: entity.description,
      templateType: _categoryToString(entity.category),
      subject: entity.subject,
      body: entity.body,
      isActive: entity.isActive,
      isBuiltin: entity.isBuiltIn,
      availableVariables: entity.availableVariables,
      attachments: const [],
      updatedAt: entity.lastUpdatedAt?.toIso8601String(),
    );
  }

  static List<String> _stripBraces(List<String> vars) =>
      vars.map((v) => v.replaceAll(RegExp(r'[{}]'), '')).toList();

  static EmailTemplateCategory _categoryFromString(String type) {
    return switch (type) {
      'wish' => EmailTemplateCategory.wish,
      'reminder' => EmailTemplateCategory.reminder,
      'notification' => EmailTemplateCategory.notification,
      'document' => EmailTemplateCategory.document,
      _ => EmailTemplateCategory.notification,
    };
  }

  static String _categoryToString(EmailTemplateCategory category) {
    return switch (category) {
      EmailTemplateCategory.wish => 'wish',
      EmailTemplateCategory.reminder => 'reminder',
      EmailTemplateCategory.notification => 'notification',
      EmailTemplateCategory.document => 'document',
    };
  }
}
