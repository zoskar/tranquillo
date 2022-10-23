import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pcyb/user_status_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>();
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is LoggedOut) {
            final formKey = GlobalKey<FormBuilderState>();
            return FormBuilder(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    FormBuilderTextField(
                      name: 'loginPicker',
                      maxLength: 20,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        label: Text('login'),
                      ),
                    ),
                    FormBuilderTextField(
                      obscureText: true,
                      name: 'passPicker',
                      maxLength: 20,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        label: Text('password'),
                      ),
                    ),
                    ElevatedButton(
                      child: const Text(
                        'Login',
                      ),
                      onPressed: () {
                        formKey.currentState!.saveAndValidate();
                        Map<String, dynamic>? data =
                            formKey.currentState?.value;
                        context.read<UserCubit>().logIn(
                              data?['loginPicker'],
                              data?['passPicker'],
                            );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is LoggedIn) {
            return const Center(child: Text('Zalogowano'));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
