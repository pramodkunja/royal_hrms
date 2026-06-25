class Designation {
  const Designation({
    required this.id,
    required this.name,
    required this.isActive,
    required this.departmentId,
    this.departmentName = '',
  });

  final String id;
  final String name;
  final bool isActive;
  final String departmentId;
  final String departmentName;

  Designation copyWith({
    String? id,
    String? name,
    bool? isActive,
    String? departmentId,
    String? departmentName,
  }) {
    return Designation(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      departmentId: departmentId ?? this.departmentId,
      departmentName: departmentName ?? this.departmentName,
    );
  }
}

class Department {
  const Department({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    this.designations = const [],
    this.serverDesignationCount,
    this.employeeCount = 0,
  });

  final String id;
  final String name;
  final String description;
  final bool isActive;
  final List<Designation> designations;

  /// Count from the API list response — used before designations are loaded.
  final int? serverDesignationCount;

  /// Employee count returned by the API list response.
  final int employeeCount;

  int get designationCount =>
      designations.isNotEmpty ? designations.length : (serverDesignationCount ?? 0);

  Department copyWith({
    String? id,
    String? name,
    String? description,
    bool? isActive,
    List<Designation>? designations,
    int? serverDesignationCount,
    int? employeeCount,
  }) {
    return Department(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      designations: designations ?? this.designations,
      serverDesignationCount:
          serverDesignationCount ?? this.serverDesignationCount,
      employeeCount: employeeCount ?? this.employeeCount,
    );
  }
}
