import 'package:hive/hive.dart';
part 'user_response.g.dart';

@HiveType(typeId: 1)
class UserResponse {
  @HiveField(0)
  final String fullname;
  @HiveField(1)
  final String city;
  @HiveField(2)
  final String country;
  @HiveField(3)
  final String instagram;
  @HiveField(4)
  final String about;
  @HiveField(5)
  final String facebook;
  @HiveField(6)
  final String twitter;
  @HiveField(7)
  final String job;
  @HiveField(8)
  final String avatar;
  UserResponse({
    required this.fullname,
    required this.city,
    required this.country,
    required this.instagram,
    required this.about,
    required this.facebook,
    required this.twitter,
    required this.job,
    required this.avatar,
  });

  UserResponse copyWith({
    String? fullname,
    String? city,
    String? country,
    String? instagram,
    String? about,
    String? facebook,
    String? twitter,
    String? job,
    String? avatar,
  }) {
    return UserResponse(
      fullname: fullname ?? this.fullname,
      city: city ?? this.city,
      country: country ?? this.country,
      job: job ?? this.job,
      avatar: avatar ?? this.avatar,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      twitter: twitter ?? this.twitter,
      about: about ?? this.about,
    );
  }

  @override
  String toString() {
    return 'UserResponse(fullname: $fullname, city: $city, country: $country, job: $job)';
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'fullname': fullname,
      'city': city,
      'country': country,
      'job': job,
      'avatar': avatar,
      'facebook': facebook,
      'instagram': instagram,
      'twitter': twitter,
      'about': about,
    };
  }

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return UserResponse(
      fullname: data['fullname']?.toString() ?? '',
      city: data['city']?.toString() ?? '',
      country: data['country']?.toString() ?? '',
      job: data['job']?.toString() ?? '',
      avatar: data['avatar']?.toString() ?? '',
      instagram: data['instagram']?.toString() ?? '',
      twitter: data['twitter']?.toString() ?? '',
      about: data['about']?.toString() ?? '',
      facebook: data['facebook']?.toString() ?? '',
    );
  }
}
