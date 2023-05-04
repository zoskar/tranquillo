import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tranquillo/app.dart';
import 'package:tranquillo/generated/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'tranquillo',
  );

  runApp(const App());
}
