import 'package:dict/cubits/dictando_cubit.dart';
import 'package:dict/presentation/widgets/beat_widget.dart';
import 'package:dict/presentation/widgets/carousel_widget.dart';
import 'package:dict/presentation/widgets/keyboard.dart';
import 'package:dict/presentation/widgets/my_app_bar.dart';
import 'package:dict/presentation/widgets/staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/cubits/auth_cubit.dart';
import 'package:dict/presentation/hamburger_menu.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainScale = MediaQuery.of(context).size.height / 90;
    double width = MediaQuery.of(context).size.width;

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
            appBar: const MyAppBar(),
            body: Column(
              children: [
                SizedBox(
                  // 24: lines and spaces + 12: noteScale
                  height: (mainScale * 24 + 12 * mainScale) / 4,
                  child: BlocBuilder<DictandoCubit, DictandoState>(
                    builder: (context, state) =>
                        CarouselWidget(width: width, mainScale: mainScale),
                  ),
                ),
                SizedBox(
                  // 24: lines and spaces + 9: noteScale
                  height: mainScale * 24 + 12 * mainScale,
                  child: Stack(
                    children: [
                      // TODO(zoskar): change order
                      BeatWidget(step: mainScale),
                      Staff(distance: mainScale),
                    ],
                  ),
                ),
                const Keyboard(),
              ],
            ),
          );
  }
}
