import 'package:tranquillo/cubits/dictando_cubit.dart';
import 'package:tranquillo/cubits/user_data_cubit.dart';
import 'package:tranquillo/data/classes.dart';
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
                    showDialog<bool>(
                      context: context,
                      builder: (context) => DeleteDictandoAlertDialog(
                        id: id,
                      ),
                    );
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

class DeleteDictandoAlertDialog extends StatelessWidget {
  const DeleteDictandoAlertDialog({
    required this.id,
    this.isSolution = false,
    Key? key,
  }) : super(key: key);
  final String id;
  final bool isSolution;
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Delete Dictando'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (isSolution) {
                context.read<UserDataCubit>().deleteSolution(id);
              } else {
                context.read<UserDataCubit>().deleteDictando(id);
              }
              Navigator.pop(context, false);
            },
            child: const Text(
              'Detele',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
}
