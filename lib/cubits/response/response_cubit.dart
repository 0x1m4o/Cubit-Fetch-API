import 'package:bloc/bloc.dart';
import 'package:cubitfetchapi/models/user_response.dart';
import 'package:cubitfetchapi/repository/profile_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'response_state.dart';
part 'response_cubit.freezed.dart';

class ResponseCubit extends Cubit<ResponseState> {
  ProfileRepository profileRepository = ProfileRepository();
  ResponseCubit() : super(ResponseState.initial());
  @override
  void getAllDataOfUser(String username, String token) async {
    emit(ResponseState.loading());

    final result = await profileRepository.getAllData(username, token);
    result.fold((left) => emit(ResponseState.error(left)),
        (right) => emit(ResponseState.success(right)));
  }
}