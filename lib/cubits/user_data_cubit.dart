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

  getData() async {
    emit(FetchingInProgress());

    try {
      DataSnapshot response = await _dataRef.child('someData').get();
      final data = response.value as dynamic;
      emit(FetchedData(data: data));
    } catch (err, st) {
      print('Error: $err, $st');
    }
  }

  addNote() async {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref('');

    await dbRef.set(
      Dictando([
        Beat([Note(duration: 2, pitch: 3)])
      ]).toJson(),
    );
  }
}

abstract class UserDataState {}

class FetchedData extends UserDataState {
  FetchedData({required this.data});

  final String data;
}

class FetchingInProgress extends UserDataState {}

class NoData extends UserDataState {}
