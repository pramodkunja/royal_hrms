import 'dart:typed_data';

import '../../data/models/department_model.dart';
import '../../data/models/email_template_model.dart';
import '../../domain/entities/department.dart';
import '../../domain/entities/email_template.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasource/settings_remote_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._remoteDataSource);

  final SettingsRemoteDataSource _remoteDataSource;

  @override
  Future<List<EmailTemplate>> getEmailTemplates() async {
    final models = await _remoteDataSource.fetchEmailTemplates();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<EmailTemplate> createEmailTemplate(EmailTemplate template) async {
    final model = EmailTemplateModel.fromEntity(template);
    final created = await _remoteDataSource.createEmailTemplate(model);
    return created.toEntity();
  }

  @override
  Future<EmailTemplate> updateEmailTemplate(EmailTemplate template) async {
    final id = int.parse(template.id);
    final patch = EmailTemplateModel.fromEntity(template).toUpdateJson();
    final updated = await _remoteDataSource.updateEmailTemplate(id, patch);
    return updated.toEntity();
  }

  @override
  Future<EmailTemplate> toggleActiveEmailTemplate(
    String id,
    bool isActive,
  ) async {
    final updated = await _remoteDataSource.toggleActiveEmailTemplate(
      int.parse(id),
      isActive,
    );
    return updated.toEntity();
  }

  @override
  Future<void> deleteEmailTemplate(String id) async {
    await _remoteDataSource.deleteEmailTemplate(int.parse(id));
  }

  @override
  Future<void> deleteEmailTemplateAttachment(
    String templateId,
    int attachmentId,
  ) async {
    await _remoteDataSource.deleteEmailTemplateAttachment(
      int.parse(templateId),
      attachmentId,
    );
  }

  @override
  Future<EmailTemplateAttachment> uploadEmailTemplateAttachment(
    String templateId,
    String filename,
    Uint8List bytes,
  ) async {
    final model = await _remoteDataSource.uploadEmailTemplateAttachment(
      int.parse(templateId),
      filename,
      bytes,
    );
    return model.toEntity();
  }

  // ---------------------------------------------------------------------------
  // Departments
  // ---------------------------------------------------------------------------

  @override
  Future<List<Department>> getDepartments() async {
    final models = await _remoteDataSource.fetchDepartments();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Department> createDepartment(Department dept) async {
    final model = DepartmentModel.fromEntity(dept);
    final created = await _remoteDataSource.createDepartment(model);
    return created.toEntity();
  }

  @override
  Future<Department> updateDepartment(Department dept) async {
    final id = int.parse(dept.id);
    final patch = DepartmentModel.fromEntity(dept).toUpdateJson();
    final updated = await _remoteDataSource.updateDepartment(id, patch);
    return updated.toEntity();
  }

  @override
  Future<void> deleteDepartment(String id) async {
    await _remoteDataSource.deleteDepartment(int.parse(id));
  }

  // ---------------------------------------------------------------------------
  // Designations
  // ---------------------------------------------------------------------------

  @override
  Future<List<Designation>> getDesignations(String departmentId) async {
    final deptId = int.parse(departmentId);
    final models = await _remoteDataSource.fetchDesignations(deptId);
    return models
        .where((m) => m.departmentId == deptId)
        .map((m) => m.toEntity())
        .toList();
  }

  @override
  Future<Designation> createDesignation(Designation designation) async {
    final model = DesignationModel.fromEntity(designation);
    final created = await _remoteDataSource.createDesignation(model);
    return created.toEntity();
  }

  @override
  Future<Designation> updateDesignation(Designation designation) async {
    final id = int.parse(designation.id);
    final patch = DesignationModel.fromEntity(designation).toUpdateJson();
    final updated = await _remoteDataSource.updateDesignation(id, patch);
    return updated.toEntity();
  }

  @override
  Future<void> deleteDesignation(String id) async {
    await _remoteDataSource.deleteDesignation(int.parse(id));
  }
}
