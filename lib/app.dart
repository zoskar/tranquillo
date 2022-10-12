import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class App extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: 'zoskar12@gmail.com', password: 'zoskar12@gmail.com');
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    return Center(
      child: Text('OK'),
    );
  }
}
