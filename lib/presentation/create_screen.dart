import 'package:dict/cubits/beat_cubit.dart';
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
    if (context.read<BeatCubit>().state is InitState) {
      context.read<BeatCubit>().init();
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
                      BlocBuilder<BeatCubit, BeatState>(
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
                        context.read<BeatCubit>().up();
                      },
                      icon: const Icon(Icons.arrow_circle_up),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<BeatCubit>().down();
                      },
                      icon: const Icon(Icons.arrow_circle_down),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<BeatCubit>().left();
                      },
                      icon: const Icon(Icons.arrow_circle_left),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<BeatCubit>().right();
                      },
                      icon: const Icon(Icons.arrow_circle_right),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<BeatCubit>().delete();
                      },
                      icon: const Icon(Icons.delete_rounded),
                    )
                  ],
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.b,
            onPressed: () {
              context.read<UserDataCubit>().addNote();

              // context.read<UserDataCubit>().removeData();
              // context.read<AuthCubit>().logOut();
            },
            child: const Icon(Icons.logout),
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
          for (var i = 0; i < context.read<BeatCubit>().beat.notes.length; i++)
            Column(
              children: [
                SizedBox(
                  height: distance *
                      step *
                      context.read<BeatCubit>().beat.notes[i].pitch,
                ),
                Icon(
                  NotesIcons.eight,
                  color: i == context.read<BeatCubit>().index
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
