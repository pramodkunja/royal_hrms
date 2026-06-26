import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/company_info_model.dart';

mixin CompanyInfoDataSourceMixin {
  ApiClient get apiClient;

  Future<CompanyInfoModel> fetchCompanyInfo() async {
    final response = await apiClient.get<Map<String, dynamic>>(
      ApiConstants.companyInfoEndpoint,
    );
    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from company info endpoint.');
    }
    return CompanyInfoModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<CompanyInfoModel> updateCompanyInfo(
    Map<String, dynamic> data, {
    Uint8List? logoBytes,
    String? logoFilename,
  }) async {
    final formFields = data.map(
      (k, v) => MapEntry(k, v?.toString() ?? ''),
    );
    final formData = FormData.fromMap({
      ...formFields,
      if (logoBytes != null)
        'logo': MultipartFile.fromBytes(
          logoBytes,
          filename: logoFilename ?? 'logo.jpg',
        ),
    });

    final response = await apiClient.put<Map<String, dynamic>>(
      ApiConstants.companyInfoEndpoint,
      data: formData,
    );
    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException('Unexpected response from company info update.');
    }
    return CompanyInfoModel.fromJson(body['data'] as Map<String, dynamic>);
  }
}
