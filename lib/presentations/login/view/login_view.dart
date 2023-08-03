import 'package:bloc_cfl/app/utils/utils.dart';
import 'package:bloc_cfl/presentations/login/bloc/auth_bloc.dart';
import 'package:bloc_cfl/presentations/login/bloc/login_event.dart';
import 'package:bloc_cfl/presentations/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: userNameCtrl,
                decoration: const InputDecoration(hintText: "Username"),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "enter username";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: passwordCtrl,
                decoration: const InputDecoration(hintText: "Password"),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "enter password";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              BlocConsumer<LoginBloc, LogInState>(
                listener: (context, state) {
                  if (state.isSuccessState == true) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                    Utils.showSnack(context, message: "Login success");
                  }
                  if (state.isFailedState == true) {
                    Utils.showSnack(context, message: state.errorMessage);
                  } else {}
                },
                builder: (context, state) {
                  return (state.isInitStateState || state.isSuccessState)
                      ? MaterialButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<LoginBloc>(context).add(
                                LoginEvent(
                                  username: userNameCtrl.text.trim(),
                                  password: passwordCtrl.text.trim(),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
