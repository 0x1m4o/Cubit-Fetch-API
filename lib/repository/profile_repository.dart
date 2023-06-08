import 'package:cubitfetchapi/models/login_request.dart';
import 'package:cubitfetchapi/models/login_response.dart';
import 'package:cubitfetchapi/models/register_request.dart';
import 'package:cubitfetchapi/models/register_response.dart';
import 'package:cubitfetchapi/models/user_response.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class ProfileRepository {
  Dio _dio = Dio();

  Future<Either<String, UserResponse>> getAllData(String username, String token) async {
    try {
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));

      Response _response;
      _response = await _dio.get(
        'https://profile-card-api.vercel.app/api/$username',
        options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer $token",
        })
      );

      UserResponse _userResponse = UserResponse.fromJson(_response.data);
      return Right(_userResponse);
    } on DioException catch (e) {
      String errorMessage = e.response!.data.toString();
      if (e.type == DioExceptionType.badResponse) {
        errorMessage = e.response!.data['error'];
      }

      return Left(errorMessage);
    }
  }
}
