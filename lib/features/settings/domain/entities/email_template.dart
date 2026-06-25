enum EmailTemplateCategory { document, notification, reminder, wish }

class EmailTemplateAttachment {
  const EmailTemplateAttachment({
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
  final DateTime uploadedAt;

  String get displaySize {
    if (sizeBytes < 1024 * 1024) {
      return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class EmailTemplate {
  const EmailTemplate({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
    required this.subject,
    required this.body,
    required this.description,
    this.isBuiltIn = false,
    this.isActive = true,
    this.availableVariables = const [],
    this.attachments = const [],
    this.lastUpdatedAt,
  });

  final String id;
  final String name;
  final String slug;
  final EmailTemplateCategory category;
  final String subject;
  final String body;
  final String description;
  final bool isBuiltIn;
  final bool isActive;
  final List<String> availableVariables;
  final List<EmailTemplateAttachment> attachments;
  final DateTime? lastUpdatedAt;

  EmailTemplate copyWith({
    String? id,
    String? name,
    String? slug,
    EmailTemplateCategory? category,
    String? subject,
    String? body,
    String? description,
    bool? isBuiltIn,
    bool? isActive,
    List<String>? availableVariables,
    List<EmailTemplateAttachment>? attachments,
    DateTime? lastUpdatedAt,
  }) {
    return EmailTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      category: category ?? this.category,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      description: description ?? this.description,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      isActive: isActive ?? this.isActive,
      availableVariables: availableVariables ?? this.availableVariables,
      attachments: attachments ?? this.attachments,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }
}
