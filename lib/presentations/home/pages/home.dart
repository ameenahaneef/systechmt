import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:systechmt/data/sources/shared_preference.dart';
import 'package:systechmt/presentations/home/bloc/bloc_bloc.dart';
import 'package:systechmt/presentations/login/pages/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BlocBloc>().add(Loaded());
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataList'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await SharedPrefsHelper.saveLoginState(false);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<BlocBloc, BlocState>(builder: (context, state) {
              if (state is BlocLoading) {
                return const CircularProgressIndicator();
              } else if (state is BlocError) {
                return const Text('Error');
              } else if (state is BlocLoaded) {
                return ListView.builder(
                  itemCount: state.stud.length,
                  itemBuilder: (context, index) {
                    final article = state.stud[index];
                    return ListTile(
                      title: Text(
                        article.title,
                      ),
                      subtitle: Text(article.subtitle),
                    );
                  },
                );
              }
              return const SizedBox();
            }),
          )
        ],
      ),
    );
  }
}
