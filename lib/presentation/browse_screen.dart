import 'package:dict/cubits/auth_cubit.dart';
import 'package:dict/cubits/user_data_cubit.dart';
import 'package:dict/presentation/hamburger_menu.dart';
import 'package:dict/presentation/widgets/dictando_tile.dart';
import 'package:dict/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<UserDataCubit>().state is NoData) {
      context.read<UserDataCubit>().getUserDictandos();
    }

    return Scaffold(
      drawer: const HamburgerMenu(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.myNewGradient,
          ),
        ),
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (state is FetchedData &&
              context.watch<AuthCubit>().state is Authenticated) {
            return RefreshIndicator(
              onRefresh: context.read<UserDataCubit>().getUserDictandos,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                  itemCount: state.userDictandos.length,
                  itemBuilder: (context, index) => DictandoTile(
                    dictando: state.userDictandos[index].dictando,
                    id: state.userDictandos[index].id,
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
