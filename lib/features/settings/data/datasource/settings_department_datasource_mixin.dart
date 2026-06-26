import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/department_model.dart';

mixin DepartmentDataSourceMixin {
  ApiClient get apiClient;

  Future<List<DepartmentModel>> fetchDepartments() async {
    final response = await apiClient.get<Map<String, dynamic>>(
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

  Future<DepartmentModel> createDepartment(DepartmentModel model) async {
    final response = await apiClient.post<Map<String, dynamic>>(
      ApiConstants.settingsDepartmentsEndpoint,
      data: model.toCreateJson(),
    );
    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException(
        'Unexpected response from create department endpoint.',
      );
    }
    return DepartmentModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<DepartmentModel> updateDepartment(
    int id,
    Map<String, dynamic> patch,
  ) async {
    final response = await apiClient.patch<Map<String, dynamic>>(
      '${ApiConstants.settingsDepartmentsEndpoint}$id/',
      data: patch,
    );
    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException(
        'Unexpected response from update department endpoint.',
      );
    }
    return DepartmentModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<void> deleteDepartment(int id) async {
    await apiClient.delete<Map<String, dynamic>>(
      '${ApiConstants.settingsDepartmentsEndpoint}$id/',
    );
  }

  Future<List<DesignationModel>> fetchDesignations(int departmentId) async {
    final response = await apiClient.get<Map<String, dynamic>>(
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

  Future<DesignationModel> createDesignation(DesignationModel model) async {
    final response = await apiClient.post<Map<String, dynamic>>(
      ApiConstants.settingsDesignationsEndpoint,
      data: model.toCreateJson(),
    );
    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException(
        'Unexpected response from create designation endpoint.',
      );
    }
    return DesignationModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<DesignationModel> updateDesignation(
    int id,
    Map<String, dynamic> patch,
  ) async {
    final response = await apiClient.patch<Map<String, dynamic>>(
      '${ApiConstants.settingsDesignationsEndpoint}$id/',
      data: patch,
    );
    final body = response.data;
    if (body == null || body['data'] is! Map<String, dynamic>) {
      throw const ApiException(
        'Unexpected response from update designation endpoint.',
      );
    }
    return DesignationModel.fromJson(body['data'] as Map<String, dynamic>);
  }

  Future<void> deleteDesignation(int id) async {
    await apiClient.delete<Map<String, dynamic>>(
      '${ApiConstants.settingsDesignationsEndpoint}$id/',
    );
  }
}
