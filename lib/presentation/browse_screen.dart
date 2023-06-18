import 'package:tranquillo/cubits/dictando_cubit.dart';
import 'package:tranquillo/cubits/user_data_cubit.dart';
import 'package:tranquillo/presentation/hamburger_menu.dart';
import 'package:tranquillo/presentation/widgets/my_app_bar.dart';
import 'package:tranquillo/presentation/widgets/dictando_tile.dart';
import 'package:tranquillo/util/app_colors.dart';
import 'package:tranquillo/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The screen that displays all the dictandos of the user.
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<DictandoCubit>().init();
          Navigator.pushReplacementNamed(context, '/create');
        },
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (state is FetchedData) {
            return Column(
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
                  child: RefreshIndicator(
                    onRefresh: context.read<UserDataCubit>().getUserDictandos,
                    child: ListView.builder(
                      itemCount: state.userDictandos.length,
                      itemBuilder: (context, index) => DictandoTile(
                        dictando: state.userDictandos[index].dictando,
                        id: state.userDictandos[index].id,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
