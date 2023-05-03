import 'package:dict/cubits/dictando_cubit.dart';
import 'package:dict/presentation/hamburger_menu.dart';
import 'package:dict/presentation/widgets/beat_widget.dart';
import 'package:dict/presentation/widgets/carousel_widget.dart';
import 'package:dict/presentation/widgets/my_app_bar.dart';
import 'package:dict/presentation/widgets/staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainScale = MediaQuery.of(context).size.height / 90;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const HamburgerMenu(),
      appBar: const MyAppBar(),
      body: Column(
        children: [
          CarouselWidget(width: width, mainScale: mainScale),
          SizedBox(
            height: mainScale * 24 + 12 * mainScale,
            child: Stack(
              children: [
                // TODO(zoskar): change order
                BlocBuilder<DictandoCubit, DictandoState>(
                  builder: (context, state) => BeatWidget(
                    step: mainScale,
                    preview: true,
                  ),
                ),
                Staff(distance: mainScale, isTappable: false),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  context.read<DictandoCubit>().beatLeft();
                },
                heroTag: null,
                child: const Icon(Icons.arrow_back),
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<DictandoCubit>().beatRight(preview: true);
                },
                heroTag: null,
                child: const Icon(Icons.arrow_forward),
              )
            ],
          )
        ],
      ),
    );
  }
}
