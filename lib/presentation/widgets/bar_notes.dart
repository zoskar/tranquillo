import 'package:tranquillo/cubits/dictando_cubit.dart';
import 'package:tranquillo/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarNotes extends StatelessWidget {
  const BarNotes({
    required this.step,
    this.preview = false,
    Key? key,
  }) : super(key: key);

  final double step;
  final bool preview;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DictandoCubit, DictandoState>(
        builder: (context, state) => SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0;
                  i <
                      context
                          .read<DictandoCubit>()
                          .dictando
                          .bars[context.read<DictandoCubit>().barIndex]
                          .notes
                          .length;
                  i++)
                Column(
                  children: [
                    SizedBox(
                      height: context
                              .read<DictandoCubit>()
                              .dictando
                              .bars[context.read<DictandoCubit>().barIndex]
                              .notes[i]
                              .pitch *
                          step,
                    ),
                    SizedBox(
                      width: 40 +
                          5 *
                              step /
                              context
                                  .read<DictandoCubit>()
                                  .dictando
                                  .bars[context.read<DictandoCubit>().barIndex]
                                  .notes[i]
                                  .duration
                                  .abs(),
                      // TODO(zoskar): remove workaround
                      height: 0,
                      child: Icon(
                        context
                            .read<DictandoCubit>()
                            .dictando
                            .bars[context.read<DictandoCubit>().barIndex]
                            .notes[i]
                            .getNoteIcon(),
                        color: i == context.read<DictandoCubit>().noteIndex &&
                                !preview
                            ? AppColors.a
                            : Colors.black,
                        size: 12 * step,
                      ),
                    ),
                  ],
                ),
              const SizedBox(width: 48)
            ],
          ),
        ),
      );
}
