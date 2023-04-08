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

  final double distance = 3;
  final double step = 2.5;
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
                  height:
                      9.5 * context.read<DictandoCubit>().beat.notes[i].pitch,
                ),
                Icon(
                  Notes.eight,
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

// TODO(zoskar): refactor
class Staff extends StatelessWidget {
  const Staff({required this.distance, Key? key}) : super(key: key);
  final double distance;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(
            height: 39,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(0);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(1);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(2);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(3);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(4);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(5);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(6);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(7);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(8);
            },
            child: const Divider(color: Colors.black, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(9);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(10);
            },
            child: const Divider(color: Colors.black, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(11);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(12);
            },
            child: const Divider(color: Colors.black, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(13);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(14);
            },
            child: const Divider(color: Colors.black, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(15);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(16);
            },
            child: const Divider(color: Colors.black, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(17);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(18);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(19);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(20);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(21);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print('aaa');
              context.read<DictandoCubit>().setPitch(22);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(23);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print('aaa');
              context.read<DictandoCubit>().setPitch(24);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
        ],
      );
}
