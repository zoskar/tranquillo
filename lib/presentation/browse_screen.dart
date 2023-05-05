import 'package:tranquillo/cubits/user_data_cubit.dart';
import 'package:tranquillo/presentation/hamburger_menu.dart';
import 'package:tranquillo/presentation/widgets/dictando_tile.dart';
import 'package:tranquillo/presentation/widgets/my_app_bar.dart';
import 'package:tranquillo/presentation/widgets/solution_tile.dart';
import 'package:tranquillo/util/app_colors.dart';
import 'package:tranquillo/util/fonts.dart';
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
      appBar: const MyAppBar(),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (state is FetchedData) {
            return RefreshIndicator(
              onRefresh: context.read<UserDataCubit>().getUserDictandos,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: AppColors.myNewGradient,
                    ),
                    height: 32,
                    width: double.infinity,
                    child: const Text(
                      'Dictandos',
                      style: AppTextStyles.white20,
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.userDictandos.length,
                      itemBuilder: (context, index) => DictandoTile(
                        dictando: state.userDictandos[index].dictando,
                        id: state.userDictandos[index].id,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: AppColors.myNewGradient,
                    ),
                    height: 32,
                    width: double.infinity,
                    child: const Text(
                      'Solutions',
                      style: AppTextStyles.white20,
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.userSolutions.length,
                      itemBuilder: (context, index) => SolutionTile(
                        dictando: state.userSolutions[index].dictando,
                        id: state.userSolutions[index].id,
                      ),
                    ),
                  ),
                ],
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
