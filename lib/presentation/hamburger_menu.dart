import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:tranquillo/cubits/dictando_cubit.dart';
import 'package:tranquillo/cubits/file_cubit.dart';
import 'package:tranquillo/util/app_colors.dart';
import 'package:tranquillo/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquillo/cubits/auth_cubit.dart';
import 'package:tranquillo/cubits/user_data_cubit.dart';

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
                  'Browse',
                  style: AppTextStyles.black24,
                ),
                onTap: () {
                  context.read<FileCubit>().stop();
                  context.read<UserDataCubit>().getUserDictandos();
                  Navigator.pushReplacementNamed(context, '/browse');
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_forward_ios_rounded),
                title: const Text(
                  'Create dictando',
                  style: AppTextStyles.black24,
                ),
                onTap: () {
                  context.read<DictandoCubit>().init();
                  Navigator.pushReplacementNamed(context, '/create');
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_forward_ios_rounded),
                title: const Text(
                  'Upload MP3',
                  style: AppTextStyles.black24,
                ),
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['mp3'],
                  );
                  if (result != null) {
                    File file = File(result.files.single.path as String);
                    context.read<FileCubit>().uploadFile(file);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_forward_ios_rounded),
                title: const Text(
                  'Log out',
                  style: AppTextStyles.black24,
                ),
                onTap: () {
                  context.read<FileCubit>().stop();
                  Navigator.pushReplacementNamed(context, '/');
                  context.read<AuthCubit>().logOut();
                  context.read<UserDataCubit>().removeData();
                  // TODO(zoskar): investigate if this is needed
                  // context.read<DictandoCubit>().clearDictando();
                },
              ),
            ],
          ),
        ),
      );
}
