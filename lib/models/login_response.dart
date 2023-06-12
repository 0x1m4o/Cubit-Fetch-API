import 'package:hive/hive.dart';
part 'login_response.g.dart';

@HiveType(typeId: 2)
class LoginResponse {
  @HiveField(0)
  String username;
  @HiveField(1)
  String token;
  @HiveField(2)
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
