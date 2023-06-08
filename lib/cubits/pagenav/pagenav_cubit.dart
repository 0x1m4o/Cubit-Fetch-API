import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pagenav_state.dart';

class PagenavCubit extends Cubit<PagenavState> {
  PagenavCubit() : super(PagenavState.initial());

  void toggleText(String toggleText) {
    if (toggleText == 'Sign Up') {
      emit(state.copyWith(currentVal: 'Sign Up'));
    } else {
      emit(state.copyWith(currentVal: 'Sign In'));
    }
  }
}
