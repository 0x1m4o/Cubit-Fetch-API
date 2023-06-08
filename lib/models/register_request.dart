class RegisterRequest {
  String username;
  String password;
  String fullname;
  String city;
  String country;
  String job;
  RegisterRequest({
    required this.username,
    required this.password,
    required this.fullname,
    required this.city,
    required this.country,
    required this.job,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'fullname': fullname,
      'city': city,
      'country': country,
      'job': job,
    };
  }

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      username: json['username']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
      fullname: json['fullname']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      job: json['job']?.toString() ?? '',
    );
  }
}
