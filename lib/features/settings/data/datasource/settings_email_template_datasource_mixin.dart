import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/email_template_model.dart';

mixin EmailTemplateDataSourceMixin {
  ApiClient get apiClient;

  Future<List<EmailTemplateModel>> fetchEmailTemplates() async {
    final response = await apiClient.get<Map<String, dynamic>>(
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

  Future<EmailTemplateModel> createEmailTemplate(
    EmailTemplateModel model,
  ) async {
    final response = await apiClient.post<Map<String, dynamic>>(
      ApiConstants.settingsEmailTemplatesEndpoint,
      data: model.toCreateJson(),
    );
    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from create endpoint.');
    }
    return EmailTemplateModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<EmailTemplateModel> updateEmailTemplate(
    int id,
    Map<String, dynamic> patch,
  ) async {
    final response = await apiClient.patch<Map<String, dynamic>>(
      '${ApiConstants.settingsEmailTemplatesEndpoint}$id/',
      data: patch,
    );
    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from update endpoint.');
    }
    return EmailTemplateModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<EmailTemplateModel> toggleActiveEmailTemplate(
    int id,
    bool isActive,
  ) async {
    final response = await apiClient.patch<Map<String, dynamic>>(
      '${ApiConstants.settingsEmailTemplatesEndpoint}$id/',
      data: EmailTemplateModel.toToggleJson(isActive),
    );
    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from toggle endpoint.');
    }
    return EmailTemplateModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<void> deleteEmailTemplate(int id) async {
    await apiClient.delete<Map<String, dynamic>>(
      '${ApiConstants.settingsEmailTemplatesEndpoint}$id/',
    );
  }

  Future<void> deleteEmailTemplateAttachment(
    int templateId,
    int attachmentId,
  ) async {
    await apiClient.delete<Map<String, dynamic>>(
      '${ApiConstants.settingsEmailTemplatesEndpoint}$templateId/',
      queryParameters: {'attachment_id': attachmentId},
    );
  }

  Future<EmailTemplateAttachmentModel> uploadEmailTemplateAttachment(
    int templateId,
    String filename,
    Uint8List bytes,
  ) async {
    final formData = FormData.fromMap({
      'attachment': MultipartFile.fromBytes(bytes, filename: filename),
    });
    final response = await apiClient.post<Map<String, dynamic>>(
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
}
