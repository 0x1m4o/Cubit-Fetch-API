// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String errorMsg;
  AuthError({
    required this.errorMsg,
  });
}

class AuthLoginSuccess extends AuthState {
  final LoginResponse data;
  AuthLoginSuccess({
    required this.data,
  });
}

class AuthRegisterSuccess extends AuthState {
  final RegisterResponse data;
  AuthRegisterSuccess({
    required this.data,
  });
}
