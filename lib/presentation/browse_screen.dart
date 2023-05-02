import 'package:dict/cubits/auth_cubit.dart';
import 'package:dict/cubits/dictando_cubit.dart';
import 'package:dict/cubits/user_data_cubit.dart';
import 'package:dict/presentation/hamburger_menu.dart';
import 'package:dict/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

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
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        trailing: PopupMenuButton<String>(
                          onSelected: (String choice) {
                            switch (choice) {
                              case 'Open':
                                break;
                              case 'Edit':
                                context.read<DictandoCubit>().editDictando(
                                      state.userDictandos[index].dictando,
                                      state.userDictandos[index].id,
                                    );
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/create',
                                );

                                break;
                              case 'Delete':
                                context.read<UserDataCubit>().deleteDictando(
                                      state.userDictandos[index].id,
                                    );
                                context
                                    .read<UserDataCubit>()
                                    .getUserDictandos();

                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              {'Open', 'Edit', 'Delete'}
                                  .map(
                                    (String choice) => PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    ),
                                  )
                                  .toList(),
                        ),
                        title: Text(
                          state.userDictandos[index].dictando.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const Divider(),
                    ],
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
