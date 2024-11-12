import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systechmt/core/constants/app_colors.dart';
import 'package:systechmt/data/sources/shared_preference.dart';
import 'package:systechmt/presentations/home/pages/home.dart';
import 'package:systechmt/presentations/login/widgets/textfield.dart';
import 'package:systechmt/presentations/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: kBlack,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Formfield(
                    labelText: 'Username', controller: usernameController),
                height10,
                Formfield(
                    labelText: 'Password', controller: passwordController),
                height10,
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                      SharedPrefsHelper.saveLoginState(true);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return const HomeScreen();
                      }));
                    } else if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(
                                LoginButtonPressed(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                      child: const Text('Login'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
