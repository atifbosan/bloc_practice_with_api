import 'package:bloc_cfl/app/const/globals.dart';
import 'package:bloc_cfl/data/provider/local_storage/local_db.dart';
import 'package:bloc_cfl/data/respositories/auth_respository.dart';
import 'package:bloc_cfl/presentations/login/bloc/login_event.dart';
import 'package:bloc_cfl/presentations/login/bloc/login_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEventInit, LogInState> {
  AuthRepository repository;
  LoginBloc({required this.repository}) : super(LogInState()) {
    on<LoginEvent>((event, emit) => login(event, emit, state));
  }

  login(event, emit, state) async {
    try {
      emit(
        state.copyWith(
          isLoadingState: true,
          isInitStateState: false,
          isFailedState: false,
          isSuccessState: false,
          isProfileUpdatedState: false,
        ),
      );
      var res = await repository.login(
        username: event.username,
        password: event.password,
      );
      print("Show Response:${res}");
      if (res != null && res['Status'] == true) {
        Globals.Userno = res['data'][0]['UserId'];
        Globals.userName = res['data'][0]['Username'];
        LocalDB.setData('Userno', res['data'][0]['UserId']);
        LocalDB.setData('UserName', res['data'][0]['Username']);
        emit(
          state.copyWith(
            isLoadingState: false,
            isSuccessState: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoadingState: false,
            isSuccessState: false,
            isFailedState: true,
            isInitStateState: true,
            errorMessage: "Invalid username/password",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingState: false,
          isSuccessState: false,
          isFailedState: true,
          isInitStateState: true,
          errorMessage: "System error",
        ),
      );
    }
  }
}
