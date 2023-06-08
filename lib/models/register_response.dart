class RegisterResponse {
  String msg;
  RegisterResponse({
    required this.msg,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'msg': msg,
    };
  }

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      msg: json['msg']?.toString() ?? '',
    );
  }
}
