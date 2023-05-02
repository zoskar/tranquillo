import 'package:dict/cubits/dictando_cubit.dart';
import 'package:dict/presentation/hamburger_menu.dart';
import 'package:dict/presentation/widgets/carousel_widget.dart';
import 'package:dict/presentation/widgets/staff.dart';
import 'package:dict/presentation/widgets/static_beat_widget.dart';
import 'package:dict/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  final double mainScale = 10;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const HamburgerMenu(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.myNewGradient,
          ),
        ),
      ),
      body: Column(
        children: [
          CarouselWidget(width: width, mainScale: mainScale),
          SizedBox(
            height: mainScale * 24 + 9 * mainScale,
            child: Stack(
              children: [
                // TODO(zoskar): change order
                BlocBuilder<DictandoCubit, DictandoState>(
                  builder: (context, state) => StaticBeatWidget(
                    beat: context
                        .read<DictandoCubit>()
                        .dictando
                        .beats[context.read<DictandoCubit>().beatIndex],
                    step: mainScale,
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
