import 'package:dict/presentation/hamburger_menu.dart';
import 'package:dict/util/app_colors.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: const Center(),
        drawer: const HamburgerMenu(),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.myNewGradient,
            ),
          ),
        ),
      );
}
