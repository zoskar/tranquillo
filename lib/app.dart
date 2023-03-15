import 'package:dict/presentation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/cubits/user_data_cubit.dart';
import 'package:dict/presentation/create_screen.dart';
import 'package:dict/presentation/login/login_screen.dart';
import 'package:dict/cubits/auth_cubit.dart';
import 'package:dict/cubits/beat_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit()..init();
    final userDataCubit = UserDataCubit();
    final beatCubit = BeatCubit();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: authCubit),
        BlocProvider<UserDataCubit>.value(value: userDataCubit),
        BlocProvider<BeatCubit>.value(value: beatCubit),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: const Color(0xFFEBEBEB),
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRoutes.homepage.route,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is Unauthenticated) {
              return const LoginScreen();
            } else {
              return const CreateScreen();
            }
          },
        ),
      ),
    );
  }
}
