import 'package:dict/cubits/auth_cubit.dart';
import 'package:dict/cubits/dictando_cubit.dart';
import 'package:dict/cubits/user_data_cubit.dart';
import 'package:dict/data/classes.dart';
import 'package:dict/presentation/hamburger_menu.dart';
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

class DictandoTile extends StatelessWidget {
  const DictandoTile({
    required this.dictando,
    required this.id,
    Key? key,
  }) : super(key: key);

  final Dictando dictando;
  final String id;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ListTile(
            trailing: PopupMenuButton<String>(
              onSelected: (String choice) {
                switch (choice) {
                  case 'Open':
                    context.read<DictandoCubit>().editDictando(
                          dictando,
                          id,
                        );
                    Navigator.pushReplacementNamed(
                      context,
                      '/preview',
                    );
                    break;
                  case 'Edit':
                    context.read<DictandoCubit>().editDictando(
                          dictando,
                          id,
                        );
                    Navigator.pushReplacementNamed(
                      context,
                      '/create',
                    );
                    break;
                  case 'Delete':
                    context.read<UserDataCubit>().deleteDictando(id);
                    context.read<UserDataCubit>().getUserDictandos();
                    break;
                }
              },
              itemBuilder: (BuildContext context) => {'Open', 'Edit', 'Delete'}
                  .map(
                    (String choice) => PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    ),
                  )
                  .toList(),
            ),
            title: Text(
              dictando.name,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const Divider(),
        ],
      );
}
