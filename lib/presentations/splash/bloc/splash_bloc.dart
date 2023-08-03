import 'package:bloc/bloc.dart';
import 'package:bloc_cfl/presentations/splash/bloc/splash_event_state.dart';
import 'package:bloc_cfl/data/provider/local_storage/local_db.dart';

class DBBloc extends Bloc<DBEvent, DBState> {
  DBBloc() : super(DBState()) {
    on<DBEvent>((event, emit) async {
      var id = await LocalDB.initiate();
      emit(DBState(ID: id));
    });
  }
}
