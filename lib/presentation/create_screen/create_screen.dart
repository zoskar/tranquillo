import 'package:dict/cubits/dictando_cubit.dart';
import 'package:dict/presentation/create_screen/widgets/beat_widget.dart';
import 'package:dict/presentation/create_screen/widgets/keyboard.dart';
import 'package:dict/presentation/create_screen/staff.dart';
import 'package:dict/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/cubits/auth_cubit.dart';
import 'package:dict/presentation/hamburger_menu.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  final double mainScale = 10;

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;

    if (context.read<DictandoCubit>().state is InitState) {
      context.read<DictandoCubit>().init();
    }
    return context.watch<AuthCubit>().state is AuthenticationInProgress
        ? const Scaffold(
            body: Center(child: Center(child: CircularProgressIndicator())),
          )
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
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  SizedBox(
                    // 24: lines and spaces + 9: noteScale
                    height: mainScale * 24 + 9 * mainScale,
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
                  const Keyboard(),
                ],
              ),
            ),
          );
  }
}
