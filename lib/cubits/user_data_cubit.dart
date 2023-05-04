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
    List<DictandoFromDatabase> userSolutions = [];
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
      response =
          await _dataRef.child('solutions/${auth.currentUser?.uid}').get();
      if (response.value != null) {
        final data =
            Map<String, dynamic>.from(response.value! as Map<Object?, Object?>);

        data.forEach((k, v) {
          userSolutions.add(
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
    emit(
      FetchedData(
        userDictandos: userDictandos,
        userSolutions: userSolutions,
      ),
    );
  }

  /// Saves a dictando to the database
  Future<void> saveDictando(Dictando dictando, String id) async {
    emit(FetchingInProgress());
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref('dictandos/${auth.currentUser!.uid}');
    DatabaseReference newPostRef = dbRef.push();
    if (id != '') {
      await deleteDictando(id);
    }
    await newPostRef.set(dictando.toJson());
    await getUserDictandos();
  }

  /// Saves a solution to the database
  Future<void> saveSolution(Dictando dictando, String id) async {
    emit(FetchingInProgress());
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref('solutions/${auth.currentUser!.uid}');
    DatabaseReference newPostRef = dbRef.push();
    if (id != '') {
      await deleteSolution(id);
    }
    await newPostRef.set(dictando.toJson());
    await getUserDictandos();
  }

  /// Deletes a dictando from the database
  Future<void> deleteDictando(String id) async {
    await _dataRef
        .child('dictandos/${auth.currentUser?.uid}/$id')
        .remove()
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
    await getUserDictandos();
  }

  /// Deletes a solution from the database
  Future<void> deleteSolution(String id) async {
    await _dataRef
        .child('solutions/${auth.currentUser?.uid}/$id')
        .remove()
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
    await getUserDictandos();
  }
}

abstract class UserDataState {}

class FetchedData extends UserDataState {
  FetchedData({required this.userDictandos, required this.userSolutions});

  final List<DictandoFromDatabase> userDictandos;
  final List<DictandoFromDatabase> userSolutions;
}

class FetchingInProgress extends UserDataState {}

class NoData extends UserDataState {}

// TODO(zoskar): implement error
class UserDataError extends UserDataState {}
