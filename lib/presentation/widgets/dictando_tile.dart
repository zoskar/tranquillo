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
            title: Text(
              dictando.name,
              style: const TextStyle(fontSize: 20),
            ),
            trailing: DictandoMenu(dictando: dictando, id: id),
            onTap: () {
              context.read<DictandoCubit>().editDictando(
                    dictando,
                    id,
                  );
              Navigator.pushReplacementNamed(
                context,
                '/preview',
              );
            },
          ),
          const Divider(),
        ],
      );
}

class DictandoMenu extends StatelessWidget {
  const DictandoMenu({
    required this.dictando,
    required this.id,
    Key? key,
  }) : super(key: key);

  final Dictando dictando;
  final String id;

  @override
  Widget build(BuildContext context) => PopupMenuButton<String>(
        onSelected: (String choice) {
          switch (choice) {
            case 'Compare with dictando':
              showDialog<bool>(
                context: context,
                builder: (context) => CompareToDictandoAlertDialog(
                  compareDictando: dictando,
                ),
              );
              break;
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
        itemBuilder: (BuildContext context) => {
          'Compare with dictando',
          'Open',
          'Edit',
          'Delete',
        }
            .map(
              (String choice) => PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              ),
            )
            .toList(),
      );
}

/// CompareToDictandoAlertDialog is used to compare dictando with other dictando
class CompareToDictandoAlertDialog extends StatelessWidget {
  const CompareToDictandoAlertDialog({
    required this.compareDictando,
    Key? key,
  }) : super(key: key);

  // Dictando that is to be compared with user choice
  final Dictando compareDictando;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Pick Dictando to compare with'),
        content: BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            if (state is FetchedData) {
              return SizedBox(
                // TODO(zoskar): remove workaround
                width: 0,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.userDictandos.length,
                  itemBuilder: (context, index) {
                    final dictandoFromDatabase = state.userDictandos[index];
                    // Do not allow to compare dictando to itself
                    if (dictandoFromDatabase.dictando == compareDictando) {
                      return const SizedBox.shrink();
                    }
                    return ListTile(
                      title: Text(dictandoFromDatabase.dictando.name),
                      onTap: () {
                        context.read<DictandoCubit>().compareDictando(
                              compareDictando,
                              dictandoFromDatabase.dictando,
                            );
                        Navigator.pushReplacementNamed(
                          context,
                          '/compare',
                        );
                      },
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
}

class DeleteDictandoAlertDialog extends StatelessWidget {
  const DeleteDictandoAlertDialog({
    required this.id,
    Key? key,
  }) : super(key: key);
  final String id;
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
              context.read<UserDataCubit>().deleteDictando(id);
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
