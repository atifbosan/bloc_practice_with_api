import 'package:bloc_cfl/presentations/home/view/home_view.dart';
import 'package:bloc_cfl/presentations/login/view/login_view.dart';
import 'package:bloc_cfl/presentations/splash/view/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routArgs) {
    switch (routArgs.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const SplashView());
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginView());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeView());
      default:
        return MaterialPageRoute(builder: (context) => LoginView());
    }
  }
}
