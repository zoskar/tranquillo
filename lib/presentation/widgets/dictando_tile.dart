import 'package:dict/cubits/dictando_cubit.dart';
import 'package:dict/cubits/user_data_cubit.dart';
import 'package:dict/data/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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