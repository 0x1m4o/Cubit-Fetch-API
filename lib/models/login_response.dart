class LoginResponse {
  String username;
  String token;
  String msg;
  LoginResponse({
    required this.username,
    required this.token,
    required this.msg,
  });

  factory LoginResponse.initial() {
    return LoginResponse(username: '', token: '', msg: '');
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      username: json['username'] as String,
      token: json['token'] as String,
      msg: json['msg'] as String,
    );
  }
}
