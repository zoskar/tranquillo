import 'package:dict/data/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// UserDataCubit is responsible for fetching and saving user data
class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(NoData());

  FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference _dataRef = FirebaseDatabase.instance.ref();

  /// Removes all data from the cubit
  void removeData() {
    emit(NoData());
  }

  /// Fetches all user dictandos from the database
  Future<void> getUserDictandos() async {
    List<DictandoFromDatabase> userDictandos = [];
    emit(FetchingInProgress());

    try {
      DataSnapshot response =
          await _dataRef.child('dictandos/${auth.currentUser?.uid}').get();
      if (response.value != null) {
        final data =
            Map<String, dynamic>.from(response.value! as Map<Object?, Object?>);

        data.forEach((k, v) {
          userDictandos.add(
            DictandoFromDatabase(
              dictando: Dictando.parseDictando(v),
              id: k,
            ),
          );
        });
      }
    } catch (err, st) {
      print('Error: $err, $st');
      emit(NoData());
      return;
    }
    emit(FetchedData(userDictandos: userDictandos));
  }

  /// Saves a dictando to the database
  Future<void> saveDictando(Dictando dictando, String id) async {
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref('dictandos/${auth.currentUser!.uid}');
    DatabaseReference newPostRef = dbRef.push();
    if (id != '') {
      await deleteDictando(id);
    }
    await newPostRef.set(dictando.toJson());
  }

  /// Deletes a dictando from the database
  Future<void> deleteDictando(String id) async {
    await _dataRef
        .child('dictandos/${auth.currentUser?.uid}/$id')
        .remove()
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
  }
}

abstract class UserDataState {}

class FetchedData extends UserDataState {
  FetchedData({required this.userDictandos});

  final List<DictandoFromDatabase> userDictandos;
}

class FetchingInProgress extends UserDataState {}

class NoData extends UserDataState {}

// TODO(zoskar): implement error
class UserDataError extends UserDataState {}
