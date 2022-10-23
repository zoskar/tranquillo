import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(LoggedOut());
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> logIn(String login, String pass) async {
    emit(LoggingIn());
    try {
      await auth.signInWithEmailAndPassword(email: login, password: pass);
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          emit(LoggedOut());
        } else {
          emit(LoggedIn());
        }
      });
    } catch (err) {
      emit(LoggedOut());
      print('Error: $err');
    }
  }
}

abstract class UserState {}

class LoggedOut extends UserState {}

class LoggingIn extends UserState {}

class LoggedIn extends UserState {}
