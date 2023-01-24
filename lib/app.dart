import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/cubits/balance_cubit.dart';
import 'package:dict/home_screen.dart';
import 'package:dict/login/login_screen.dart';
import 'package:dict/cubits/auth_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit()..init();
    final balanceCubit = BalanceCubit();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: authCubit),
        BlocProvider<BalanceCubit>.value(value: balanceCubit),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: const Color(0xFFEBEBEB),
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is Unauthenticated) {
              return const LoginScreen();
            } else {
              return const HomeScreen();
            }
          },
        ),
      ),
    );
  }
}
