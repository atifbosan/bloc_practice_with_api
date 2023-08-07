import 'dart:io';

import 'package:bloc_cfl/data/models/comments_model.dart';
import 'package:bloc_cfl/data/models/products_model.dart';
import 'package:bloc_cfl/data/models/user_model.dart';

abstract class HomeSate {}

class HomeInitSate extends HomeSate {}

class HomeCommentsState extends HomeSate {
  final List<CommentsModel> commentsList;
  final bool isLoading;
  final String message;
  final String error;
  HomeCommentsState({
    this.commentsList = const <CommentsModel>[],
    this.isLoading = false,
    this.error = '',
    this.message = '',
  });

  HomeCommentsState copyWith({
    List<CommentsModel>? commentsList,
    bool? isLoading,
    String? message,
    String? error,
  }) {
    return HomeCommentsState(
      commentsList: commentsList ?? this.commentsList,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}

class HomeProductState extends HomeSate {
  final List<ProductsModel> productList;
  final bool isLoading;
  final String message;
  final String error;
  HomeProductState({
    this.productList = const <ProductsModel>[],
    this.isLoading = false,
    this.error = '',
    this.message = '',
  });

  HomeProductState copyWith({
    List<ProductsModel>? productList,
    bool? isLoading,
    String? message,
    String? error,
  }) {
    return HomeProductState(
      productList: productList ?? this.productList,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}

class HomeUsersState extends HomeSate {
  final List<UserModel> usersList;
  File? imageFile;
  final bool isLoading;
  final String message;
  final String error;
  HomeUsersState({
    this.usersList = const <UserModel>[],
    this.imageFile,
    this.isLoading = false,
    this.error = '',
    this.message = '',
  });

  HomeUsersState copyWith({
    List<UserModel>? usersList,
    File? imageFile,
    bool? isLoading,
    String? message,
    String? error,
  }) {
    return HomeUsersState(
      usersList: usersList ?? this.usersList,
      imageFile: imageFile ?? this.imageFile,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}
