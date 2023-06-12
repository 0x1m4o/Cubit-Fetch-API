import 'dart:convert';

import 'package:cubitfetchapi/models/user_response.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class ProfileRepository {
  final _dio = Dio();

  Future<Either<String, UserResponse>> getAllData(
      String username, String token) async {
    try {
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));

      Response response;
      response =
          await _dio.get('https://profile-card-api.vercel.app/api/$username',
              options: Options(
                headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $token",
                },
              ));

      UserResponse userResponse = UserResponse.fromJson(response.data);
      return Right(userResponse);
    } on DioException catch (e) {
      String errorMessage = e.response!.data.toString();
      if (e.type == DioExceptionType.badResponse) {
        errorMessage = e.response!.data['error'];
      }

      return Left(errorMessage);
    }
  }

  Future<Either<String, Object>> editData(
      String username, String token, UserResponse throwuserResponse) async {
    try {
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));

      Response response;
      final requestData = {
        'fullname': throwuserResponse.fullname,
        'city': throwuserResponse.city,
        'country': throwuserResponse.country,
        'job': throwuserResponse.job,
        'twitter': throwuserResponse.twitter,
        'about': throwuserResponse.about,
        'avatar': throwuserResponse.avatar,
        'instagram': throwuserResponse.instagram,
        'facebook': throwuserResponse.facebook,
      };

      FormData formData = FormData.fromMap(requestData);

      response = await _dio.put(
        'https://profile-card-api.vercel.app/api/$username/edit',
        data: {
          'fullname': throwuserResponse.fullname,
          'city': throwuserResponse.city,
          'country': throwuserResponse.country,
          'job': throwuserResponse.job,
          'twitter': throwuserResponse.twitter,
          'about': throwuserResponse.about,
          'avatar': throwuserResponse.avatar,
          'instagram': throwuserResponse.instagram,
          'facebook': throwuserResponse.facebook,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('Response: ${response.data}');
      print('Response data: ${response.data['data']}');
      print('Response FormData :: ${formData}');

      // UserResponse userResponse = UserResponse.fromJson(response.data['data']);

      return Right(response.data);
    } on DioException catch (e) {
      String errorMessage = e.response!.data.toString();
      if (e.type == DioExceptionType.badResponse) {
        errorMessage = e.response!.data['error'];
      }

      return Left(errorMessage);
    }
  }
}
