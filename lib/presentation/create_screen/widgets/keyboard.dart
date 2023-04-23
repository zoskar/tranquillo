import 'package:dict/cubits/dictando_cubit.dart';
import 'package:dict/cubits/user_data_cubit.dart';
import 'package:dict/util/notes_icons.dart';
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
                  context.read<DictandoCubit>().noteLeft();
                },
                icon: const Icon(Icons.arrow_circle_left),
              ),
              IconButton(
                onPressed: () {
                  context.read<DictandoCubit>().noteRight();
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
                onPressed: () {
                  context.read<DictandoCubit>().addBeat();
                  context.read<UserDataCubit>().saveDictando(
                        context.read<DictandoCubit>().dictando,
                      );
                  context.read<DictandoCubit>().clearDictando();
                },
                icon: const Icon(Icons.save),
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
          )
        ],
      );
}
