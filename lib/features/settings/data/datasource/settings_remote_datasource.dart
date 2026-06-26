import 'dart:typed_data';

import '../models/company_info_model.dart';
import '../models/department_model.dart';
import '../models/email_template_model.dart';
import '../models/smtp_config_model.dart';

abstract class SettingsRemoteDataSource {
  // SMTP
  Future<List<SmtpConfigModel>> getSmtpConfigs();
  Future<SmtpConfigModel> createSmtpConfig(Map<String, dynamic> data);
  Future<SmtpConfigModel> updateSmtpConfig(String id, Map<String, dynamic> data);
  Future<void> deleteSmtpConfig(String id);
  Future<void> setSmtpConfigActive(String id);
  Future<void> testSmtpConfig(String id);

  // Email Templates
  Future<List<EmailTemplateModel>> fetchEmailTemplates();
  Future<EmailTemplateModel> createEmailTemplate(EmailTemplateModel model);
  Future<EmailTemplateModel> updateEmailTemplate(int id, Map<String, dynamic> patch);
  Future<EmailTemplateModel> toggleActiveEmailTemplate(int id, bool isActive);
  Future<void> deleteEmailTemplate(int id);
  Future<void> deleteEmailTemplateAttachment(int templateId, int attachmentId);
  Future<EmailTemplateAttachmentModel> uploadEmailTemplateAttachment(
    int templateId,
    String filename,
    Uint8List bytes,
  );

  // Company Info
  Future<CompanyInfoModel> fetchCompanyInfo();
  Future<CompanyInfoModel> updateCompanyInfo(
    Map<String, dynamic> data, {
    Uint8List? logoBytes,
    String? logoFilename,
  });

  // Departments
  Future<List<DepartmentModel>> fetchDepartments();
  Future<DepartmentModel> createDepartment(DepartmentModel model);
  Future<DepartmentModel> updateDepartment(int id, Map<String, dynamic> patch);
  Future<void> deleteDepartment(int id);

  // Designations
  Future<List<DesignationModel>> fetchDesignations(int departmentId);
  Future<DesignationModel> createDesignation(DesignationModel model);
  Future<DesignationModel> updateDesignation(int id, Map<String, dynamic> patch);
  Future<void> deleteDesignation(int id);
}
