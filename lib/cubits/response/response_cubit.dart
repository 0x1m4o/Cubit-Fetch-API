import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubitfetchapi/models/user_response.dart';
import 'package:cubitfetchapi/repository/profile_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'response_state.dart';
part 'response_cubit.freezed.dart';

class ResponseCubit extends Cubit<ResponseState> {
  ProfileRepository profileRepository = ProfileRepository();
  ResponseCubit() : super(ResponseState.initial());
  void getAllDataOfUser(String username, String token) async {
    emit(ResponseState.loading());

    final result = await profileRepository.getAllData(username, token);
    result.fold((left) => emit(ResponseState.error(left)),
        (right) => emit(ResponseState.success(right)));
  }

  void editDataUser(
      String username, String token, UserResponse throwUserResponse) async {
    emit(ResponseState.loading());

    final result =
        await profileRepository.editData(username, token, throwUserResponse);
    result.fold((left) => emit(ResponseState.error(left)),
        (right) => emit(ResponseState.updsuccess()));
  }
}
