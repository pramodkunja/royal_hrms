import 'dart:typed_data';

import '../entities/department.dart';
import '../entities/email_template.dart';

abstract class SettingsRepository {
  Future<List<EmailTemplate>> getEmailTemplates();
  Future<EmailTemplate> createEmailTemplate(EmailTemplate template);
  Future<EmailTemplate> updateEmailTemplate(EmailTemplate template);
  Future<EmailTemplate> toggleActiveEmailTemplate(String id, bool isActive);
  Future<void> deleteEmailTemplate(String id);
  Future<void> deleteEmailTemplateAttachment(String templateId, int attachmentId);
  Future<EmailTemplateAttachment> uploadEmailTemplateAttachment(
    String templateId,
    String filename,
    Uint8List bytes,
  );

  // Departments
  Future<List<Department>> getDepartments();
  Future<Department> createDepartment(Department dept);
  Future<Department> updateDepartment(Department dept);
  Future<void> deleteDepartment(String id);

  // Designations
  Future<List<Designation>> getDesignations(String departmentId);
  Future<Designation> createDesignation(Designation designation);
  Future<Designation> updateDesignation(Designation designation);
  Future<void> deleteDesignation(String id);
}
