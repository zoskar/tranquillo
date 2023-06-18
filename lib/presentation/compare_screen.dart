import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquillo/cubits/dictando_cubit.dart';
import 'package:tranquillo/presentation/hamburger_menu.dart';
import 'package:tranquillo/presentation/preview_screen.dart';
import 'package:tranquillo/presentation/widgets/my_app_bar.dart';
import 'package:tranquillo/presentation/widgets/staff.dart';
import 'package:tranquillo/presentation/widgets/static_beat_widget.dart';
import 'package:flutter/material.dart';

/// The screen that displays two dictandos side by side.
class CompareScreen extends StatelessWidget {
  const CompareScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainScale = MediaQuery.of(context).size.height / 90;

    return Scaffold(
      drawer: const Drawer(child: HamburgerMenu()),
      appBar: const MyAppBar(),
      body: SizedBox(
        child: BlocBuilder<DictandoCubit, DictandoState>(
          builder: (context, state) => Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Stack(
                  children: [
                    StaticBeatWidget(
                      step: mainScale,
                      beat: context
                          .read<DictandoCubit>()
                          .dictando
                          .beats[context.read<DictandoCubit>().beatIndex],
                    ),
                    Staff(distance: mainScale, isTappable: false),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Stack(
                  children: [
                    StaticBeatWidget(
                      step: mainScale,
                      beat: context
                          .read<DictandoCubit>()
                          .dictandoB
                          .beats[context.read<DictandoCubit>().beatIndex],
                    ),
                    Staff(distance: mainScale, isTappable: false),
                  ],
                ),
              ),
              const BeatChangeArrows(forTwoDictandos: true)
            ],
          ),
        ),
      ),
    );
  }
}
