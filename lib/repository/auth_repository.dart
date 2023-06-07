import 'package:cubitfetchapi/models/login_request.dart';
import 'package:cubitfetchapi/models/login_response.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class AuthRepository {
  Dio _dio = Dio();

  Future<Either<String, LoginResponse>> signUser(
      {required LoginRequest loginRequest}) async {
    try {
      Response _response;
      _response = await _dio.post('https://reqres.in/api/login',
          data: loginRequest.toJson());

      LoginResponse result = LoginResponse.fromJson(_response.data);
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
// class AuthRepository {
//   Dio _dio = Dio();

//   Future<String> signUser(
//       {required String email, required String password}) async {
//     Response _response;
//     Map<String, dynamic> responseData = {'email': email, 'password': password};
//     _response =
//         await _dio.post('https://reqres.in/api/login', data: responseData);

//     String result = _response.data.toString();
//     return result;
//   }
// }
