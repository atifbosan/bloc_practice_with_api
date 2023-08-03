import 'package:equatable/equatable.dart';

class LogInState {
  final bool isLoadingState;
  final bool isInitStateState;
  final bool isSuccessState;
// final bool isProfileUpdatedState;
  final bool isFailedState;
  final String errorMessage;
// final ParentDataModel? parentDataModel;

  LogInState({
    this.isLoadingState = false,
    this.isInitStateState = true,
    this.isSuccessState = false,
    // this.isProfileUpdatedState = false,
    this.isFailedState = false,
    this.errorMessage = "",
    // this.parentDataModel,
  });

  LogInState copyWith({
    bool? isLoadingState,
    bool? isInitStateState,
    bool? isSuccessState,
    bool? isProfileUpdatedState,
    bool? isFailedState,
    String? errorMessage,
    // ParentDataModel? parentDataModel,
  }) {
    return LogInState(
      isLoadingState: isLoadingState ?? this.isLoadingState,
      isInitStateState: isInitStateState ?? this.isInitStateState,
      isSuccessState: isSuccessState ?? this.isSuccessState,
      // isProfileUpdatedState: isProfileUpdatedState ?? this.isProfileUpdatedState,
      isFailedState: isFailedState ?? this.isFailedState,
      errorMessage: errorMessage ?? this.errorMessage,
      // parentDataModel: parentDataModel??this.parentDataModel,
    );
  }
}
