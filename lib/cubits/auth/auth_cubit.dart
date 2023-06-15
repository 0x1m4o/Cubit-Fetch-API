import 'package:profileapp/models/login_request.dart';
import 'package:profileapp/models/login_response.dart';
import 'package:profileapp/models/register_request.dart';
import 'package:profileapp/models/register_response.dart';
import 'package:profileapp/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/utils/constant.dart' as constants;
import 'package:hive_flutter/hive_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  late Box box;
  AuthCubit() : super(AuthInitial());

  void signInWithEmailPassword(LoginRequest loginRequest) async {
    emit(AuthLoading());
    try {
      final dataResponse =
          await AuthRepository().signUser(loginRequest: loginRequest);
      dataResponse.fold((l) => emit(AuthError(errorMsg: l)),
          (r) => emit(AuthLoginSuccess(data: r)));
    } catch (e) {
      emit(AuthError(errorMsg: e.toString()));
    }
  }

  void registerWithEmailPassword(RegisterRequest registerRequest) async {
    emit(AuthLoading());
    try {
      final dataResponse =
          await AuthRepository().registerUser(registerRequest: registerRequest);
      dataResponse.fold((l) => emit(AuthError(errorMsg: l)),
          (r) => emit(AuthRegisterSuccess(data: r)));
    } catch (e) {
      emit(AuthError(errorMsg: e.toString()));
    }
  }

  void saveLoginResponse(LoginResponse data) async {
    emit(AuthLoading());

    try {
      box = await Hive.openBox('box');
      box.put(constants.loginRespStorage, data);
      emit(SaveAuth());
    } catch (e) {
      emit(AuthError(errorMsg: e.toString()));
    }
  }
}
