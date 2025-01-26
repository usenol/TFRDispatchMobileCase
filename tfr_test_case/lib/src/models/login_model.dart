class LoginRequestModel {
  final String username;
  final String password;

  LoginRequestModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class LoginResponseModel {
  final String token;
  final String? error;

  LoginResponseModel({
    required this.token,
    this.error,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['access'] ?? '',
      error: json['error'],
    );
  }

  factory LoginResponseModel.withError(String error) {
    return LoginResponseModel(
      token: '',
      error: error,
    );
  }
} 