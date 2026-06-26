// Data layer
export 'data/datasource/settings_remote_datasource.dart';
export 'data/models/company_info_model.dart';
export 'data/models/department_model.dart';
export 'data/models/email_template_model.dart';
export 'data/models/smtp_config_model.dart';
export 'data/models/smtp_config_request_model.dart';
export 'data/repositories/settings_repository_impl.dart';

// Domain layer
export 'domain/entities/company_info.dart';
export 'domain/entities/department.dart';
export 'domain/entities/email_template.dart';
export 'domain/entities/smtp_config.dart';
export 'domain/repositories/settings_repository.dart';

// Pages — settings root
export 'presentation/pages/settings_page.dart';

// Pages — company info
export 'presentation/pages/company_info/company_info_page.dart';

// Pages — departments
export 'presentation/pages/departments/departments_page.dart';

// Pages — email templates
export 'presentation/pages/email_templates/email_templates_page.dart';

// Pages — SMTP
export 'presentation/pages/smtp/smtp_settings_page.dart';

// Pages — roles & permissions
export 'presentation/pages/roles_permissions/roles_permissions_page.dart';

// Providers
export 'presentation/providers/company_info_providers.dart';
export 'presentation/providers/departments_providers.dart';
export 'presentation/providers/email_templates_providers.dart';
export 'presentation/providers/settings_providers.dart';
export 'presentation/providers/smtp_form_state.dart';
export 'presentation/providers/smtp_settings_notifier.dart';

// Widgets — departments
export 'presentation/widgets/departments/add_edit_department_dialog.dart';

// Widgets — email templates
export 'presentation/widgets/email_templates/add_edit_email_template_dialog.dart';
export 'presentation/widgets/email_templates/email_html_preview.dart';
export 'presentation/widgets/email_templates/email_template_card.dart';
export 'presentation/widgets/email_templates/email_template_section.dart';
export 'presentation/widgets/email_templates/view_email_template_dialog.dart';

// Widgets — SMTP
export 'presentation/widgets/smtp/smtp_config_card.dart';
export 'presentation/widgets/smtp/smtp_form_dialog.dart';
