import '../../../../core/network/api_client.dart';
import 'settings_department_datasource_mixin.dart';
import 'settings_email_template_datasource_mixin.dart';
import 'settings_remote_datasource.dart';
import 'settings_smtp_datasource_mixin.dart';

class SettingsRemoteDataSourceImpl
    with
        SmtpDataSourceMixin,
        EmailTemplateDataSourceMixin,
        DepartmentDataSourceMixin
    implements SettingsRemoteDataSource {
  SettingsRemoteDataSourceImpl(this.apiClient);

  @override
  final ApiClient apiClient;
}
