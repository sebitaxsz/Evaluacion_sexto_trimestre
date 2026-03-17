class LoginRequest {
  final String apiUser;
  final String apiPassword;

  LoginRequest({
    required this.apiUser,
    required this.apiPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'api_user': apiUser,
      'api_password': apiPassword,
    };
  }
}