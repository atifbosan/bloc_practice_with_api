import 'package:equatable/equatable.dart';

abstract class LoginEventInit {}

class LoginEvent extends LoginEventInit {
  final String username;
  final String password;
  LoginEvent({required this.username, required this.password});
}


