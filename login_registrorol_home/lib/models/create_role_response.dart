import 'role.dart';

class CreateRoleResponse {
  final List<Role> data;
  final int status;

  CreateRoleResponse({
    required this.data,
    required this.status,
  });

  factory CreateRoleResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonData = json['data'] as List<dynamic>? ?? [];
    final List<Role> roles = jsonData.map((e) => Role.fromJson(e)).toList();

    return CreateRoleResponse(
      data: roles,
      status: json['status'] as int? ?? 0,
    );
  }
}