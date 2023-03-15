import 'package:flutter/material.dart';

class AppColors {
  static const a = Color(0xFF5f95c7);

  static const b = Color(0xFF3d1762);

  static const myNewGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.a, AppColors.b],
  );
}
