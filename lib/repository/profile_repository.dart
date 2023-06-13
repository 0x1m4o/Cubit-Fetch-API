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

  Future<Either<String, String>> editData(
      String username, String token, UserResponse throwuserResponse) async {
    try {
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));

      Response response;

      response = await _dio.put(
        'https://profile-card-api.vercel.app/api/$username/edit',
        data: throwuserResponse.toJson(),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      return Right(response.data.toString());
    } on DioException catch (e) {
      String errorMessage = e.response!.data.toString();
      if (e.type == DioExceptionType.badResponse) {
        errorMessage = e.response!.data['error'];
      }

      return Left(errorMessage);
    }
  }
}
