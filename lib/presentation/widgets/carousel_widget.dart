import 'package:carousel_slider/carousel_slider.dart';
import 'package:tranquillo/cubits/dictando_cubit.dart';
import 'package:tranquillo/presentation/widgets/staff.dart';
import 'package:tranquillo/presentation/widgets/static_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    required this.width,
    required this.mainScale,
    Key? key,
  }) : super(key: key);

  final double width;
  final double mainScale;

  @override
  Widget build(BuildContext context) => SizedBox(
        // 24: lines and spaces + 12: noteScale
        height: (mainScale * 24 + 12 * mainScale) / 4,
        child: BlocBuilder<DictandoCubit, DictandoState>(
          builder: (context, state) => CarouselSlider(
            carouselController:
                context.read<DictandoCubit>().carouselController,
            options: CarouselOptions(
              initialPage: context.read<DictandoCubit>().barIndex,
              enableInfiniteScroll: false,
              aspectRatio: width / mainScale / 9,
              enlargeCenterPage: true,
            ),
            items: context
                .read<DictandoCubit>()
                .dictando
                .bars
                .map(
                  (i) => Builder(
                    builder: (BuildContext context) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        context.read<DictandoCubit>().changeBar(
                              context
                                  .read<DictandoCubit>()
                                  .dictando
                                  .bars
                                  .indexOf(i),
                            );
                      },
                      child: Stack(
                        children: [
                          Staff(
                            distance: mainScale / 4,
                            isTappable: false,
                          ),
                          StaticbarWidget(
                            step: mainScale / 4,
                            bar: i,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
}
