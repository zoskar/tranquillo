import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// AuthCubit is responsible for authentication of the user
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(Unauthenticated());

  FirebaseAuth auth = FirebaseAuth.instance;

  void init() {
    emit(Unauthenticated());
  }

  /// logOut() logs out the user
  Future<void> logOut() async {
    emit(AuthenticationInProgress());
    try {
      await auth.signOut();
      emit(Unauthenticated());
    } catch (err, st) {
      print('Error: $err, $st');
    }
  }

  /// logIn() logs in the user
  Future<bool> logIn({
    required String email,
    required String password,
  }) async {
    emit(AuthenticationInProgress());

    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(Authenticated());

      return true;
    } catch (err, st) {
      print('Error: $err, $st');
      emit(Unauthenticated());
    }
    return false;
  }
}

abstract class AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthenticationInProgress extends AuthState {}
