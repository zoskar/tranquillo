import 'package:dict/presentation/login/register_screen.dart';
import 'package:dict/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dict/cubits/auth_cubit.dart';

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
      builder: (context, state) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: height / 2.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
                                Column(
                                  children: const [
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
                                  initialValue: 'zoskar12@gmail.com',
                                  name: 'email',
                                  maxLength: 20,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    labelStyle: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: isError.value
                                            ? Colors.redAccent
                                            : Colors.black,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: isError.value
                                            ? Colors.redAccent
                                            : Colors.black,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    label: const Text('email'),
                                  ),
                                ),
                                FormBuilderTextField(
                                  initialValue: 'zoskar12@gmail.com',
                                  obscureText: true,
                                  name: 'password',
                                  maxLength: 20,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    labelStyle: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: isError.value
                                            ? Colors.redAccent
                                            : Colors.black,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: isError.value
                                            ? Colors.redAccent
                                            : Colors.black,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
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
                                    if (state is Authenticated) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/create',
                                      );
                                    }
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
      ),
    );
  }
}
