import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/cubits/auth_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: const Center(child: Text('Register Screen')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            context.read<AuthCubit>().logOut,
            Navigator.pop(context),
          },
          child: const Icon(Icons.arrow_back),
        ),
      );
}
