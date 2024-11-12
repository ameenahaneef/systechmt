import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systechmt/data/repositories/api_services.dart';
import 'package:systechmt/data/sources/shared_preference.dart';
import 'package:systechmt/presentations/home/bloc/bloc_bloc.dart';
import 'package:systechmt/presentations/home/pages/home.dart';
import 'package:systechmt/presentations/login/bloc/login_bloc.dart';
import 'package:systechmt/presentations/login/pages/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await SharedPrefsHelper.getLoginState();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BlocBloc(ApiService())),
        BlocProvider(create: (context) => LoginBloc(ApiService()))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: isLoggedIn ? const HomeScreen() : const LoginScreen()),
    );
  }
}
