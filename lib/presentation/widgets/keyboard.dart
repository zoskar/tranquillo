import 'package:tranquillo/cubits/dictando_cubit.dart';
import 'package:tranquillo/cubits/user_data_cubit.dart';
import 'package:tranquillo/keys.dart';
import 'package:tranquillo/util/notes_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().noteUp();
                },
                icon: const Icon(Icons.arrow_circle_up),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().noteDown();
                },
                icon: const Icon(Icons.arrow_circle_down),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().barLeft();
                },
                icon: const Icon(Icons.arrow_circle_left),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().noteLeft();
                },
                icon: const Icon(Icons.arrow_left),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().noteRight();
                },
                icon: const Icon(Icons.arrow_right),
              ),
              IconButton(
                key: K.nextBarButton,
                onPressed: () {
                  context.read<DictandoCubit>().barRight();
                },
                icon: const Icon(Icons.arrow_circle_right),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().deleteNote();
                },
                icon: const Icon(Icons.delete_rounded),
              ),
              IconButton(
                key: K.saveButton,
                icon: const Icon(Icons.save),
                onPressed: () async {
                  await showDialog<bool>(
                    context: context,
                    builder: (context) => SaveDictandoAlertDialog(),
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().setDuration(16);
                },
                icon: const Icon(Notes.sixteen),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().setDuration(8);
                },
                icon: const Icon(Notes.eight),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().setDuration(4);
                },
                icon: const Icon(Notes.quarter),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().setDuration(2);
                },
                icon: const Icon(Notes.half),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().setDuration(1);
                },
                icon: const Icon(Notes.whole),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().setDuration(-16);
                  context.read<DictandoCubit>().setPitch(11);
                },
                icon: const Icon(Notes.sixteen_pause),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().setDuration(-8);
                  context.read<DictandoCubit>().setPitch(11);
                },
                icon: const Icon(Notes.eight_pause),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().setDuration(-4);
                  context.read<DictandoCubit>().setPitch(11);
                },
                icon: const Icon(Notes.quarter_pause),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().setDuration(-2);
                  context.read<DictandoCubit>().setPitch(11);
                },
                icon: const Icon(Notes.half_pause),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().setDuration(-1);
                  context.read<DictandoCubit>().setPitch(11);
                },
                icon: const Icon(Notes.whole_pause),
              ),
            ],
          ),
        ],
      );
}

class SaveDictandoAlertDialog extends StatelessWidget {
  SaveDictandoAlertDialog({Key? key}) : super(key: key);

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textController.text = context.read<DictandoCubit>().dictando.name;
    return AlertDialog(
      title: const Text('Save Dictando'),
      content: TextField(
        key: K.saveConfirmTextfield,
        controller: _textController,
        decoration: const InputDecoration(
          hintText: 'Dictando Name',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          key: K.saveConfirmButton,
          onPressed: () {
            final name = _textController.text.trim();
            if (name.isNotEmpty) {
              context.read<DictandoCubit>().dictando.name = name;

              context.read<UserDataCubit>().saveDictando(
                    context.read<DictandoCubit>().dictando,
                    context.read<DictandoCubit>().dictandoId,
                  );

              Navigator.pushReplacementNamed(context, '/browse');
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
