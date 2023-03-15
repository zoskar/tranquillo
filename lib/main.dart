import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dict/app.dart';
import 'package:dict/generated/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'dictanco',
  );

  runApp(const App());
}
