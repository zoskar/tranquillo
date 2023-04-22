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
    // emit(FetchingInProgress());

    // try {
    DataSnapshot response =
        await _dataRef.child('dictandos/${auth.currentUser?.uid}').get();
    final data = response.value as dynamic;
    // emit(FetchedData(data: data));
    print(data.values);
    var d = data.values.elementAt(0);
    var e = d['beats'][0]['notes'][0];
    Note n = Note(duration: e['duration'], pitch: e['pitch']);
    print(n);

    // } catch (err, st) {
    //   print('Error: $err, $st');
    // }
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
  FetchedData({required this.data});

  final String data;
}

class FetchingInProgress extends UserDataState {}

class NoData extends UserDataState {}
