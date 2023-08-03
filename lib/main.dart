import 'package:bloc_cfl/app/route/routes.dart';
import 'package:bloc_cfl/presentations/splash/bloc/splash_bloc.dart';
import 'package:bloc_cfl/presentations/splash/bloc/splash_event_state.dart';
import 'package:bloc_cfl/data/respositories/auth_respository.dart';
import 'package:bloc_cfl/data/respositories/home_respository.dart';
import 'package:bloc_cfl/presentations/home/bloc/home_bloc.dart';
import 'package:bloc_cfl/presentations/login/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DBBloc()),
          BlocProvider(
              create: (context) => LoginBloc(repository: AuthRepository())),
          BlocProvider(
              create: (context) => HomeBloc(repository: HomeRepository())),
        ],
        child: MaterialApp(
          title: 'Bloc Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: AppRoute.onGenerateRoute,
          initialRoute: '/',
        ));
  }
}
