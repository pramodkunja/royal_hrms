import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/department_model.dart';
import '../models/email_template_model.dart';

abstract class SettingsRemoteDataSource {
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

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  SettingsRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<EmailTemplateModel>> fetchEmailTemplates() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiConstants.settingsEmailTemplatesEndpoint,
    );

    final body = response.data;
    if (body == null) {
      throw const ApiException('Unexpected response: missing data body.');
    }

    final grouped = body['data'];
    if (grouped is! Map<String, dynamic>) {
      throw const ApiException(
        'Unexpected response: data field is not a grouped map.',
      );
    }

    final templates = <EmailTemplateModel>[];
    for (final categoryList in grouped.values) {
      if (categoryList is List) {
        for (final item in categoryList) {
          if (item is Map<String, dynamic>) {
            templates.add(EmailTemplateModel.fromJson(item));
          }
        }
      }
    }
    return templates;
  }

  @override
  Future<EmailTemplateModel> createEmailTemplate(EmailTemplateModel model) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiConstants.settingsEmailTemplatesEndpoint,
      data: model.toCreateJson(),
    );

    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from create endpoint.');
    }
    return EmailTemplateModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  @override
  Future<EmailTemplateModel> updateEmailTemplate(
    int id,
    Map<String, dynamic> patch,
  ) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      '${ApiConstants.settingsEmailTemplatesEndpoint}$id/',
      data: patch,
    );

    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from update endpoint.');
    }
    return EmailTemplateModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  @override
  Future<EmailTemplateModel> toggleActiveEmailTemplate(
    int id,
    bool isActive,
  ) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      '${ApiConstants.settingsEmailTemplatesEndpoint}$id/',
      data: EmailTemplateModel.toToggleJson(isActive),
    );

    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from toggle endpoint.');
    }
    return EmailTemplateModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteEmailTemplate(int id) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '${ApiConstants.settingsEmailTemplatesEndpoint}$id/',
    );
  }

  @override
  Future<void> deleteEmailTemplateAttachment(
    int templateId,
    int attachmentId,
  ) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '${ApiConstants.settingsEmailTemplatesEndpoint}$templateId/',
      queryParameters: {'attachment_id': attachmentId},
    );
  }

  @override
  Future<EmailTemplateAttachmentModel> uploadEmailTemplateAttachment(
    int templateId,
    String filename,
    Uint8List bytes,
  ) async {
    final formData = FormData.fromMap({
      'attachment': MultipartFile.fromBytes(bytes, filename: filename),
    });
    final response = await _apiClient.post<Map<String, dynamic>>(
      '${ApiConstants.settingsEmailTemplatesEndpoint}$templateId/attachments/',
      data: formData,
    );
    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from attachment upload.');
    }
    return EmailTemplateAttachmentModel.fromJson(
      body['data'] as Map<String, dynamic>,
    );
  }

  // ---------------------------------------------------------------------------
  // Departments
  // ---------------------------------------------------------------------------

  @override
  Future<List<DepartmentModel>> fetchDepartments() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiConstants.settingsDepartmentsEndpoint,
    );

    final body = response.data;
    if (body == null) {
      throw const ApiException('Unexpected response: missing data body.');
    }

    final rawList = body['data'];
    if (rawList is! List) {
      throw const ApiException(
        'Unexpected response: data field is not a list.',
      );
    }

    return rawList
        .whereType<Map<String, dynamic>>()
        .map(DepartmentModel.fromJson)
        .toList();
  }

  @override
  Future<DepartmentModel> createDepartment(DepartmentModel model) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiConstants.settingsDepartmentsEndpoint,
      data: model.toCreateJson(),
    );

    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from create department endpoint.');
    }
    return DepartmentModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  @override
  Future<DepartmentModel> updateDepartment(
    int id,
    Map<String, dynamic> patch,
  ) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      '${ApiConstants.settingsDepartmentsEndpoint}$id/',
      data: patch,
    );

    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from update department endpoint.');
    }
    return DepartmentModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteDepartment(int id) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '${ApiConstants.settingsDepartmentsEndpoint}$id/',
    );
  }

  // ---------------------------------------------------------------------------
  // Designations
  // ---------------------------------------------------------------------------

  @override
  Future<List<DesignationModel>> fetchDesignations(int departmentId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiConstants.settingsDesignationsEndpoint,
      queryParameters: {'department': departmentId},
    );

    final body = response.data;
    if (body == null) {
      throw const ApiException('Unexpected response: missing data body.');
    }

    final rawList = body['data'];
    if (rawList is! List) {
      throw const ApiException(
        'Unexpected response: designations data is not a list.',
      );
    }

    return rawList
        .whereType<Map<String, dynamic>>()
        .map(DesignationModel.fromJson)
        .toList();
  }

  @override
  Future<DesignationModel> createDesignation(DesignationModel model) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiConstants.settingsDesignationsEndpoint,
      data: model.toCreateJson(),
    );

    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from create designation endpoint.');
    }
    return DesignationModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  @override
  Future<DesignationModel> updateDesignation(
    int id,
    Map<String, dynamic> patch,
  ) async {
    final response = await _apiClient.patch<Map<String, dynamic>>(
      '${ApiConstants.settingsDesignationsEndpoint}$id/',
      data: patch,
    );

    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from update designation endpoint.');
    }
    return DesignationModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteDesignation(int id) async {
    await _apiClient.delete<Map<String, dynamic>>(
      '${ApiConstants.settingsDesignationsEndpoint}$id/',
    );
  }
}
