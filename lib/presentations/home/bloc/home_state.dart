import 'package:bloc_cfl/data/models/branch_model.dart';
import 'package:bloc_cfl/data/models/comments_model.dart';

abstract class HomeSate {}

class HomeInitSate extends HomeSate {}

class HomeStateData extends HomeSate {
  final List<CommentsModel> commentsList;
  final bool isLoading;
  final String message;
  final String error;
  HomeStateData({
    this.commentsList = const <CommentsModel>[],
    this.isLoading = false,
    this.error = '',
    this.message = '',
  });

  HomeStateData copyWith({
    List<CommentsModel>? commentsList,
    bool? isLoading,
    String? message,
    String? error,
  }) {
    return HomeStateData(
      commentsList: commentsList ?? this.commentsList,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}
