part of 'pagenav_cubit.dart';

class PagenavState {
  final String currentVal;
  PagenavState({
    required this.currentVal,
  });

  factory PagenavState.initial() {
    return PagenavState(currentVal: 'Sign Up');
  }

  @override
  String toString() => 'PagenavState(currentVal: $currentVal)';

  PagenavState copyWith({
    String? currentVal,
  }) {
    return PagenavState(
      currentVal: currentVal ?? this.currentVal,
    );
  }
}
