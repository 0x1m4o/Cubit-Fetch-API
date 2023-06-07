import 'package:cubitfetchapi/models/login_request.dart';
import 'package:cubitfetchapi/models/login_response.dart';
import 'package:cubitfetchapi/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signInWithEmailPassword(LoginRequest loginRequest) async {
    emit(AuthLoading());

    try {
      final dataResponse =
          await AuthRepository().signUser(loginRequest: loginRequest);
      dataResponse.fold((l) => emit(AuthError(errorMsg: l)),
      (r) => emit(AuthSuccess(data: r)));
    } catch (e) {
      emit(AuthError(errorMsg: e.toString()));
    }
  }
}
