import 'package:dict/cubits/dictando_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Staff extends StatelessWidget {
  const Staff({
    required this.distance,
    Key? key,
  }) : super(key: key);
  final double distance;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: 4 * distance,
          ),
          ...List.generate(
            25,
            (i) => i.isEven
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      context.read<DictandoCubit>().setPitch(i);
                    },
                    child: Divider(
                      color: i > 7 && i < 17 ? Colors.black : Colors.grey,
                      height: distance,
                    ),
                  )
                : GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      context.read<DictandoCubit>().setPitch(i);
                    },
                    child: SizedBox(height: distance, width: double.infinity),
                  ),
          ),
        ],
      );
}
