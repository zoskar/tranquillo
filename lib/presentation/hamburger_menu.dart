import 'package:dict/util/app_colors.dart';
import 'package:dict/util/fonts.dart';
import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          color: AppColors.a,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(''),
              ),
              ListTile(
                leading: const Icon(Icons.arrow_forward_ios_rounded),
                title: const Text(
                  'Przeglądaj dyktanda',
                  style: AppTextStyles.black24,
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/create');
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_forward_ios_rounded),
                title: const Text(
                  'Dodaj dyktando',
                  style: AppTextStyles.black24,
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/create');
                },
              ),

              ListTile(
                leading: const Icon(Icons.arrow_forward_ios_rounded),
                title: const Text(
                  'Wyloguj się',
                  style: AppTextStyles.black24,
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      );
}
