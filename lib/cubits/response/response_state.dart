part of 'response_cubit.dart';

@freezed
abstract class ResponseState with _$ResponseState {
  factory ResponseState.initial() = _Initial;
  factory ResponseState.loading() = _Loading;
  factory ResponseState.error(String errorMsg) = _Error;
  factory ResponseState.success(UserResponse userResponse) = _Success;
}
