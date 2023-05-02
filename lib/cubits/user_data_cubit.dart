import 'package:dict/data/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// UserDataCubit is responsible for fetching and saving user data
class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(NoData());

  FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference _dataRef = FirebaseDatabase.instance.ref();

  removeData() {
    emit(NoData());
  }

  Future<void> getUserDictandos() async {
    List<Dictando> userDictandos = [];
    emit(FetchingInProgress());

    try {
      DataSnapshot response =
          await _dataRef.child('dictandos/${auth.currentUser?.uid}').get();
      if (response.value != null) {
        final data =
            Map<String, dynamic>.from(response.value! as Map<Object?, Object?>);

        for (final element in data.values) {
          userDictandos.add(Dictando.parseDictando(element));
        }
      }
    } catch (err, st) {
      print('Error: $err, $st');
      emit(NoData());
      return;
    }
    emit(FetchedData(userDictandos: userDictandos));
  }

  saveDictando(Dictando dictando) async {
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref('dictandos/${auth.currentUser!.uid}');
    DatabaseReference newPostRef = dbRef.push();

    await newPostRef.set(dictando.toJson());
  }
}

abstract class UserDataState {}

class FetchedData extends UserDataState {
  FetchedData({required this.userDictandos});

  final List<Dictando> userDictandos;
}

class FetchingInProgress extends UserDataState {}

class NoData extends UserDataState {}

// TODO(zoskar): implement error
class UserDataError extends UserDataState {}
