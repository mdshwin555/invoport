


class LoginResponse {
  final String? message;

  LoginResponse({this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(message: json['massage']);
  }
}
