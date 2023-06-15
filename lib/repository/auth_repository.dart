import 'package:profileapp/models/login_request.dart';
import 'package:profileapp/models/login_response.dart';
import 'package:profileapp/models/register_request.dart';
import 'package:profileapp/models/register_response.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class AuthRepository {
  final dio = Dio();
  Future<Either<String, LoginResponse>> signUser(
      {required LoginRequest loginRequest}) async {
    try {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
      Response response;
      response = await dio.post('https://profile-card-api.vercel.app/api/login',
          data: loginRequest.toJson());
      LoginResponse result = LoginResponse.fromJson(response.data);
      return Right(result);
    } on DioException catch (e) {
      String errorMessage = e.response!.data.toString();
      if (e.type == DioExceptionType.badResponse) {
        errorMessage = e.response!.data['error'];
      }
      return Left(errorMessage);
    }
  }

  Future<Either<String, RegisterResponse>> registerUser(
      {required RegisterRequest registerRequest}) async {
    try {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
      Response response;

      response = await dio.post(
          'https://profile-card-api.vercel.app/api/register',
          data: registerRequest.toJson());

      RegisterResponse result = RegisterResponse.fromJson(response.data);
      return Right(result);
    } on DioException catch (e) {
      String errorMessage = e.response!.data.toString();
      if (e.type == DioExceptionType.badResponse) {
        errorMessage = e.response!.data['error'];
      }

      return Left(errorMessage);
    }
  }
}
