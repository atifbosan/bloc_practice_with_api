abstract class HomeEvent {}

class HomeLoadDataEvent extends HomeEvent {}

class HomeCommentsLoadDataEvent extends HomeEvent {
  HomeCommentsLoadDataEvent();
}

class HomeCommentsLoadPageEvent extends HomeEvent {}

class HomeProductLoadPageEvent extends HomeEvent {}

class HomeUsersEvent extends HomeEvent {}

class HomePermissionEvent extends HomeEvent {}

class HomePickImageEvent extends HomeEvent {}
