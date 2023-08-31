import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tranquillo/keys.dart';
import 'package:tranquillo/util/app_colors.dart';
import 'package:tranquillo/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tranquillo/cubits/auth_cubit.dart';

class RegisterScreen extends HookWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: width / 1.1,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: RegisterForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends HookWidget {
  RegisterForm({Key? key}) : super(key: key);
  static final formKey = GlobalKey<FormBuilderState>();
  final isError = useState(false);

  void onPressedRegister(
    BuildContext context,
    GlobalKey<FormBuilderState> formKey,
  ) async {
    bool result = formKey.currentState!.saveAndValidate();

    if (!result) {
      return;
    }

    Map<String, dynamic>? data = formKey.currentState?.value;

    await context.read<AuthCubit>().register(
          email: data?['email'] ?? '',
          password: data?['password'] ?? '',
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => FormBuilder(
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
                        'Please register',
                        style: AppTextStyles.black12,
                      ),
                    ],
                  ),
                  FormBuilderTextField(
                    key: K.registerEmailTextField,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                    name: 'email',
                    maxLength: 50,
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
                          color: isError.value ? Colors.redAccent : AppColors.c,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isError.value ? Colors.redAccent : AppColors.c,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      label: const Text('email'),
                    ),
                  ),
                  FormBuilderTextField(
                    key: K.registerPasswordlTextField,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(
                        6,
                        errorText: 'Minimum 6 characters required',
                      ),
                      FormBuilderValidators.match(
                        r'(?=.*?[#?!@$%^&*-])',
                        errorText: 'At least one special character required',
                      ),
                    ]),
                    obscureText: true,
                    name: 'password',
                    maxLength: 50,
                    autocorrect: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      counterText: '',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isError.value ? Colors.redAccent : AppColors.c,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isError.value ? Colors.redAccent : AppColors.c,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      label: const Text('password'),
                    ),
                  ),
                  FormBuilderTextField(
                    key: K.registerRepeatPasswordlTextField,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      (val) {
                        if (val !=
                            formKey.currentState?.fields['password']?.value) {
                          return 'Passwords do not match';
                        }
                        return null;
                      }
                    ]),
                    obscureText: true,
                    name: 'repeat password',
                    maxLength: 50,
                    autocorrect: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      counterText: '',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isError.value ? Colors.redAccent : AppColors.c,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isError.value ? Colors.redAccent : AppColors.c,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      label: const Text('repeat password'),
                    ),
                  ),
                  ElevatedButton(
                    key: K.registerButton,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Register'),
                    onPressed: () {
                      onPressedRegister(
                        context,
                        formKey,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
