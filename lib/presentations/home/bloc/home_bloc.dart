import 'package:bloc/bloc.dart';
import 'package:bloc_cfl/data/models/branch_model.dart';
import 'package:bloc_cfl/data/models/comments_model.dart';
import 'package:bloc_cfl/presentations/home/bloc/home_event.dart';
import 'package:bloc_cfl/presentations/home/bloc/home_state.dart';
import '../../../data/respositories/home_respository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeSate> {
  List<CommentsModel> comments = [];
  int page = 1;
  int limit = 10;
  HomeRepository repository;
  HomeBloc({required this.repository}) : super(HomeInitSate()) {
    on<HomeCommentsLoadDataEvent>(
        (event, emit) => loadComments(event, emit, state));
  }

  loadComments(event, emit, state) async {
    try {
      emit(HomeStateData(
          commentsList: comments, isLoading: true, message: '', error: ''));
      Map<String, dynamic>? resp = await repository.getComment(page: page);
      print("Show Resposne:${resp}");
      if (resp != null) {
        comments.addAll(List<CommentsModel>.from(resp['comments']
            .map<CommentsModel>((json) => CommentsModel.fromJson(json))));
        emit(HomeStateData(
            commentsList: comments, isLoading: false, message: '', error: ''));
        page++;
      } else {
        emit(HomeStateData(
            commentsList: comments,
            isLoading: false,
            message: 'No data found!',
            error: ''));
      }
    } catch (e) {
      emit(HomeStateData(
          commentsList: [], isLoading: false, message: '', error: '$e'));
    }
  }
}
