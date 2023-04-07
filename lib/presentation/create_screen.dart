import 'package:dict/cubits/dictando_cubit.dart';
import 'package:dict/util/app_colors.dart';
import 'package:dict/util/notes_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/cubits/auth_cubit.dart';
import 'package:dict/cubits/user_data_cubit.dart';
import 'package:dict/presentation/hamburger_menu.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  final double distance = 8;
  final double step = 1.5;
  @override
  Widget build(BuildContext context) {
    if (context.read<UserDataCubit>().state is NoData) {
      context.read<UserDataCubit>().getData();
    }
    if (context.read<DictandoCubit>().state is InitState) {
      context.read<DictandoCubit>().init();
    }

    return Stack(
      children: [
        if (context.watch<AuthCubit>().state is AuthenticationInProgress)
          const Center(
            child: CircularProgressIndicator(),
          ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: const HamburgerMenu(),
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.myNewGradient,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 376,
                  child: Stack(
                    children: [
                      Staff(distance: distance),
                      BlocBuilder<DictandoCubit, DictandoState>(
                        builder: (context, state) =>
                            BeatWidget(distance: distance, step: step),
                      )
                    ],
                  ),
                ),
                // Staff(distance: distance / 8),
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
                      },
                      icon: const Icon(Icons.save),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BeatWidget extends StatelessWidget {
  const BeatWidget({
    required this.distance,
    required this.step,
    Key? key,
  }) : super(key: key);

  final double distance;
  final double step;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          // TODO(zoskar): replace with foreach indexed
          for (var i = 0;
              i < context.read<DictandoCubit>().beat.notes.length;
              i++)
            Column(
              children: [
                SizedBox(
                  height: distance *
                      step *
                      context.read<DictandoCubit>().beat.notes[i].pitch,
                ),
                Icon(
                  NotesIcons.eight,
                  color: i == context.read<DictandoCubit>().noteIndex
                      ? AppColors.a
                      : Colors.black,
                  size: 88,
                ),
              ],
            ),
        ],
      );
}

class Staff extends StatelessWidget {
  const Staff({required this.distance, Key? key}) : super(key: key);
  final double distance;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 36),
          const Divider(color: Colors.grey),
          SizedBox(height: distance),
          const Divider(color: Colors.grey),
          SizedBox(height: distance),
          const Divider(color: Colors.grey),
          SizedBox(height: distance),
          const Divider(color: Colors.grey),
          SizedBox(height: distance),
          const Divider(color: Colors.black),
          SizedBox(height: distance),
          const Divider(color: Colors.black),
          SizedBox(height: distance),
          const Divider(color: Colors.black),
          SizedBox(height: distance),
          const Divider(color: Colors.black),
          SizedBox(height: distance),
          const Divider(color: Colors.black),
          SizedBox(height: distance),
          const Divider(color: Colors.grey),
          SizedBox(height: distance),
          const Divider(color: Colors.grey),
          SizedBox(height: distance),
          const Divider(color: Colors.grey),
          SizedBox(height: distance),
          const Divider(color: Colors.grey),
        ],
      );
}
