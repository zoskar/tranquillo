import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/cubits/auth_cubit.dart';
import 'package:dict/cubits/balance_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<BalanceCubit>().state is NoBalance) {
      context.read<BalanceCubit>().getBalance();
    }
    return Stack(
      children: [
        if (context.watch<AuthCubit>().state is AuthenticationInProgress)
          const Center(
            child: CircularProgressIndicator(),
          ),
        Scaffold(
          appBar: AppBar(),
          body: Center(
            child: BlocBuilder<BalanceCubit, BalanceState>(
              builder: (context, state) {
                if (state is FetchedBalance) {
                  return Text('Data from database: ${state.data}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<BalanceCubit>().removeBalance();
              context.read<AuthCubit>().logOut();
            },
            child: const Icon(Icons.logout),
          ),
        ),
      ],
    );
  }
}
