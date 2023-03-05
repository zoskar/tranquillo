import 'package:dict/cubits/beat_cubit.dart';
import 'package:dict/util/notes_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/cubits/auth_cubit.dart';
import 'package:dict/cubits/user_data_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          appBar: AppBar(),
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
                        builder: (context, state) => Row(
                          children: [
                            for (var note
                                in context.read<BeatCubit>().beat.notes)
                              Column(
                                children: [
                                  SizedBox(
                                    height: distance * step * note.pitch,
                                  ),
                                  Transform.rotate(
                                    angle: note.getAngle(),
                                    child: const Icon(
                                      NotesIcons.eight,
                                      size: 88,
                                    ),
                                  ),
                                ],
                              ),
                            // SizedBox(
                            //   height: distance *
                            //       step *
                            //       context
                            //           .read<BeatCubit>()
                            //           .beat
                            //           .notes
                            //           .last
                            //           .pitch,
                            // ),
                            // Transform.rotate(
                            //   angle: context.read<BeatCubit>().getAngle(),
                            //   child: const Icon(
                            //     Notes.eight,
                            //     size: 88,
                            //   ),
                            // ),
                            // ],
                          ],
                        ),
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
                    const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.arrow_circle_left),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<BeatCubit>().right();
                      },
                      icon: const Icon(Icons.arrow_circle_right),
                    ),
                    const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.delete_rounded),
                    )
                  ],
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<UserDataCubit>().removeData();
              context.read<AuthCubit>().logOut();
            },
            child: const Icon(Icons.logout),
          ),
        ),
      ],
    );
  }
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
