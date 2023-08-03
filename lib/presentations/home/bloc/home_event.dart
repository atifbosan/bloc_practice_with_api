abstract class HomeEvent {}

class HomeLoadDataEvent extends HomeEvent {}

class HomeCommentsLoadDataEvent extends HomeEvent {
  HomeCommentsLoadDataEvent();
}

class HomeCommentsLoadPageEvent extends HomeEvent {
  HomeCommentsLoadPageEvent();
}
