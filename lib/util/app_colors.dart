import 'package:flutter/material.dart';

class AppColors {
  static const a = Color(0xFF5f95c7);

  static const b = Color(0xFF3d1762);

  static const c = Color(0xFF6c3e7d);

  static MaterialColor myColor = MaterialColor(c.value, <int, Color>{
    50: b.withOpacity(0.1),
    100: b.withOpacity(0.2),
    200: b.withOpacity(0.3),
    300: b.withOpacity(0.4),
    400: b.withOpacity(0.5),
    500: b.withOpacity(0.6),
    600: b.withOpacity(0.7),
    700: b.withOpacity(0.8),
    800: b.withOpacity(0.9),
    900: b,
  });

  static const myNewGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[AppColors.a, AppColors.b],
  );
}
