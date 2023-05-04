import 'package:dict/data/classes.dart';
import 'package:dict/presentation/hamburger_menu.dart';
import 'package:dict/presentation/widgets/my_app_bar.dart';
import 'package:dict/presentation/widgets/staff.dart';
import 'package:dict/presentation/widgets/static_beat_widget.dart';
import 'package:flutter/material.dart';

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
      body: Stack(
        children: [
          StaticBeatWidget(
            step: mainScale,
            beat: Beat([
              Note(duration: 8, pitch: 8),
            ]),
          ),
          Staff(distance: mainScale),
        ],
      ),
    );
  }
}
