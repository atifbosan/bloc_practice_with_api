import 'package:flutter/material.dart';

class Utils {
  static showSnack(BuildContext context, {required String message}) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
}
