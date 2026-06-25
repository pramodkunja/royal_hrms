import '../../domain/entities/department.dart';

class DesignationModel {
  const DesignationModel({
    required this.id,
    required this.name,
    required this.isActive,
    required this.departmentId,
    this.departmentName = '',
  });

  final int id;
  final String name;
  final bool isActive;
  final int departmentId;
  final String departmentName;

  factory DesignationModel.fromJson(Map<String, dynamic> json) {
    return DesignationModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      departmentId: (json['department'] as num?)?.toInt() ?? 0,
      departmentName: json['department_name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toCreateJson() => {
    'name': name,
    'is_active': isActive,
    'department': departmentId,
  };

  Map<String, dynamic> toUpdateJson() => {
    'name': name,
    'is_active': isActive,
    'department': departmentId,
  };

  Designation toEntity() {
    return Designation(
      id: id.toString(),
      name: name,
      isActive: isActive,
      departmentId: departmentId.toString(),
      departmentName: departmentName,
    );
  }

  static DesignationModel fromEntity(Designation entity) {
    return DesignationModel(
      id: int.tryParse(entity.id) ?? 0,
      name: entity.name,
      isActive: entity.isActive,
      departmentId: int.tryParse(entity.departmentId) ?? 0,
      departmentName: entity.departmentName,
    );
  }
}

class DepartmentModel {
  const DepartmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    this.designationCount = 0,
    this.employeeCount = 0,
  });

  final int id;
  final String name;
  final String description;
  final bool isActive;

  /// API list returns designation_count (int), not a nested designations array.
  final int designationCount;

  /// API list returns employee_count (int).
  final int employeeCount;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      designationCount:
          (json['designation_count'] as num?)?.toInt() ?? 0,
      employeeCount:
          (json['employee_count'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toCreateJson() => {
    'name': name,
    'description': description,
    'is_active': isActive,
  };

  Map<String, dynamic> toUpdateJson() => {
    'name': name,
    'description': description,
    'is_active': isActive,
  };

  Department toEntity() {
    return Department(
      id: id.toString(),
      name: name,
      description: description,
      isActive: isActive,
      serverDesignationCount: designationCount,
      employeeCount: employeeCount,
    );
  }

  static DepartmentModel fromEntity(Department entity) {
    return DepartmentModel(
      id: int.tryParse(entity.id) ?? 0,
      name: entity.name,
      description: entity.description,
      isActive: entity.isActive,
      designationCount: entity.serverDesignationCount ?? 0,
      employeeCount: entity.employeeCount,
    );
  }
}
