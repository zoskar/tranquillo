import 'package:tranquillo/data/classes.dart';
import 'package:tranquillo/presentation/hamburger_menu.dart';
import 'package:tranquillo/presentation/widgets/my_app_bar.dart';
import 'package:tranquillo/presentation/widgets/staff.dart';
import 'package:tranquillo/presentation/widgets/static_beat_widget.dart';
import 'package:flutter/material.dart';

/// The screen that displays two dictandos side by side.
class CompareScreen extends StatelessWidget {
  const CompareScreen({
    required this.dictandoA,
    required this.dictandoB,
    Key? key,
  }) : super(key: key);

  final Dictando dictandoA;
  final Dictando dictandoB;

  @override
  Widget build(BuildContext context) {
    double mainScale = MediaQuery.of(context).size.height / 90;

    return Scaffold(
      drawer: const Drawer(child: HamburgerMenu()),
      appBar: const MyAppBar(),
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Stack(
                children: [
                  StaticBeatWidget(step: mainScale, beat: dictandoA.beats[0]),
                  Staff(distance: mainScale, isTappable: false),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Stack(
                children: [
                  StaticBeatWidget(step: mainScale, beat: dictandoB.beats[0]),
                  Staff(distance: mainScale, isTappable: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
