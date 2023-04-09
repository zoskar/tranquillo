// TODO(zoskar): refactor
import 'package:dict/cubits/dictando_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Staff extends StatelessWidget {
  const Staff({required this.distance, Key? key}) : super(key: key);
  final double distance;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(
            height: 39,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(0);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(1);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(2);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(3);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(4);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(5);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(6);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(7);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(8);
            },
            child: const Divider(color: Colors.black, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(9);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(10);
            },
            child: const Divider(color: Colors.black, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(11);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(12);
            },
            child: const Divider(color: Colors.black, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(13);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(14);
            },
            child: const Divider(color: Colors.black, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(15);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(16);
            },
            child: const Divider(color: Colors.black, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(17);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(18);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(19);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(20);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(21);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print('aaa');
              context.read<DictandoCubit>().setPitch(22);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<DictandoCubit>().setPitch(23);
            },
            child: SizedBox(height: distance * 3, width: double.infinity),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print('aaa');
              context.read<DictandoCubit>().setPitch(24);
            },
            child: const Divider(color: Colors.grey, height: 10),
          ),
        ],
      );
}
