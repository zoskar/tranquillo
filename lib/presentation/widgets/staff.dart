import 'package:tranquillo/cubits/dictando_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Staff extends StatelessWidget {
  const Staff({
    required this.distance,
    this.isTappable = true,
    Key? key,
  }) : super(key: key);
  final double distance;
  final bool isTappable;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: 5.5 * distance,
          ),
          ...List.generate(
            25,
            (i) => i.isEven
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: isTappable
                        ? () {
                            context.read<DictandoCubit>().setPitch(i);
                          }
                        : null,
                    child: Divider(
                      thickness: 0.6,
                      color: i > 7 && i < 17 ? Colors.black : Colors.black12,
                      height: distance,
                    ),
                  )
                : GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: isTappable
                        ? () {
                            context.read<DictandoCubit>().setPitch(i);
                          }
                        : null,
                    child: SizedBox(height: distance, width: double.infinity),
                  ),
          ),
        ],
      );
}
