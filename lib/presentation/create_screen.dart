import 'package:dict/cubits/dictando_cubit.dart';
import 'package:dict/presentation/widgets/staff.dart';
import 'package:dict/util/app_colors.dart';
import 'package:dict/util/notes_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/cubits/auth_cubit.dart';
import 'package:dict/cubits/user_data_cubit.dart';
import 'package:dict/presentation/hamburger_menu.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  final double mainScale = 10;
  @override
  Widget build(BuildContext context) {
    if (context.read<UserDataCubit>().state is NoData) {
      context.read<UserDataCubit>().getData();
    }
    if (context.read<DictandoCubit>().state is InitState) {
      context.read<DictandoCubit>().init();
    }
    return context.watch<AuthCubit>().state is AuthenticationInProgress
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
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
                    height: 328,
                    child: Stack(
                      children: [
                        Staff(distance: mainScale),
                        BlocBuilder<DictandoCubit, DictandoState>(
                          builder: (context, state) => BeatWidget(
                            step: mainScale,
                          ),
                        ),
                      ],
                    ),
                  ),
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
              ),
            ),
          );
  }
}

class BeatWidget extends StatelessWidget {
  const BeatWidget({
    required this.step,
    Key? key,
  }) : super(key: key);

  final double step;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          for (var i = 0;
              i < context.read<DictandoCubit>().beat.notes.length;
              i++)
            Column(
              children: [
                SizedBox(
                  height:
                      context.read<DictandoCubit>().beat.notes[i].pitch * step,
                ),
                SizedBox(
                  width: 52,
                  child: Icon(
                    context.read<DictandoCubit>().noteAt(i),
                    color: i == context.read<DictandoCubit>().noteIndex
                        ? AppColors.a
                        : Colors.black,
                    size: 88,
                  ),
                ),
              ],
            ),
        ],
      );
}
