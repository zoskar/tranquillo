import 'package:flutter/semantics.dart';

typedef K = Keys;

abstract class Keys {
  //login page
  static const loginButton = Key('loginButton');
  static const loginTextField = Key('loginTextField');
  static const passwordTextField = Key('passwordTextField');
  static const loginPageRegisterButton = Key('loginPageRegisterButton');

  //register page
  static const registerEmailTextField = Key('registerEmailTextField');
  static const registerPasswordlTextField = Key('registerPasswordlTextField');
  static const registerRepeatPasswordlTextField = Key(
    'registerRepeatPasswordlTextField',
  );
  static const registerButton = Key('registerButton');

  //browse page
  static const dictandoMoreMenu = Key('dictandoMoreMenu');
  static const dictandoCreateNew = Key('dictandoCreateNew');
  static Key dictandoOption(String option) => Key('dictandoOption$option');
  static const dictandoDeleteConfirm = Key('dictandoDeleteConfirm');

  //create page
  static const nextBarButton = Key('nextBeatButton');
  static const saveButton = Key('saveButton');
  static const playPauseButton = Key('playPauseButton');
  static const stopButton = Key('stopButton');
  static const songTile = Key('songTile');
  static const saveConfirmButton = Key('saveConfirmButton');
  static const saveConfirmTextfield = Key('saveConfirmTextfield');
}
