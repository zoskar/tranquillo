import 'package:tranquillo/presentation/browse_screen.dart';
import 'package:tranquillo/presentation/login/register_screen.dart';
import 'package:tranquillo/util/app_colors.dart';
import 'package:tranquillo/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tranquillo/cubits/auth_cubit.dart';

class LoginScreen extends HookWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormBuilderState>();

  void onPressedLogin(
    BuildContext context,
    GlobalKey<FormBuilderState> formKey, {
    VoidCallback? onError,
  }) async {
    formKey.currentState!.saveAndValidate();

    Map<String, dynamic>? data = formKey.currentState?.value;

    final result = await context.read<AuthCubit>().logIn(
          email: data?['email'] ?? '',
          password: data?['password'] ?? '',
        );

    if (!result) {
      onError?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isError = useState(false);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthenticationInProgress) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is Authenticated) {
          return const BrowseScreen();
        } else {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: height / 2.5,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.music_note,
                            size: 100,
                          ),
                          Text('Dictando')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width / 1.1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        child: FormBuilder(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: [
                                    const Column(
                                      children: [
                                        Text(
                                          'Hello',
                                          style: AppTextStyles.black20b,
                                        ),
                                        Text(
                                          'Sign in into your account',
                                          style: AppTextStyles.black12,
                                        ),
                                      ],
                                    ),
                                    FormBuilderTextField(
                                      initialValue: 'abc@wp.pl',
                                      name: 'email',
                                      maxLength: 20,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                        focusColor: AppColors.c,
                                        prefixIcon: const Icon(Icons.person),
                                        counterText: '',
                                        labelStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: isError.value
                                                ? Colors.redAccent
                                                : AppColors.c,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: isError.value
                                                ? Colors.redAccent
                                                : AppColors.c,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        label: const Text('email'),
                                      ),
                                    ),
                                    FormBuilderTextField(
                                      initialValue: 'abc@wp.pl',
                                      obscureText: true,
                                      name: 'password',
                                      maxLength: 20,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.lock),
                                        counterText: '',
                                        labelStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: isError.value
                                                ? Colors.redAccent
                                                : AppColors.c,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: isError.value
                                                ? Colors.redAccent
                                                : AppColors.c,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        label: const Text('password'),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(40),
                                        shape: const StadiumBorder(),
                                      ),
                                      child: const Text('Login'),
                                      onPressed: () {
                                        onPressedLogin(
                                          context,
                                          formKey,
                                          onError: () {
                                            isError.value = true;
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Don\'t have an account?'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Register here',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
