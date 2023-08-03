import 'package:bloc_cfl/presentations/splash/bloc/splash_bloc.dart';
import 'package:bloc_cfl/presentations/splash/bloc/splash_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final DBBloc bloc = DBBloc();
  @override
  void initState() {
    bloc.add(DBEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DBBloc, DBState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.ID != null && state.ID! > 0) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          }
        },
        builder: (context, state) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
