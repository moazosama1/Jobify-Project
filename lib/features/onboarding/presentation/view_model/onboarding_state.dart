import 'package:flutter/foundation.dart';

@immutable
class OnboardingState {
  final int currentPageIndex;
  final bool isCompleted;

  const OnboardingState({this.currentPageIndex = 0, this.isCompleted = false});

  OnboardingState copyWith({int? currentPageIndex, bool? isCompleted}) {
    return OnboardingState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
