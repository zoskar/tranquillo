import 'package:dict/data/classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(NoData());

  FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference _dataRef = FirebaseDatabase.instance.ref();

  removeData() {
    emit(NoData());
  }

  getUserDictandos() async {
    List<Dictando> userDictandos = [];
    emit(FetchingInProgress());

    try {
      DataSnapshot response =
          await _dataRef.child('dictandos/${auth.currentUser?.uid}').get();
      // emit(FetchedData(data: data));
      if (response.value != null) {
        final data =
            Map<String, dynamic>.from(response.value! as Map<Object?, Object?>);

        for (final element in data.values) {
          userDictandos.add(Dictando.parseDictando(element));
        }
        emit(FetchedData(userDictandos: userDictandos));
      }
    } catch (err, st) {
      print('Error: $err, $st');
      emit(NoData());
    }
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
