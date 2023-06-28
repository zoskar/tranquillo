import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileCubit extends Cubit<FileCubitState> {
  FileCubit()
      : storageRef = FirebaseStorage.instance.ref(),
        super(NoFile());
  final Reference storageRef;

  final player = AudioPlayer();

  void playFromUrl({String url = ''}) async {
    await player.setReleaseMode(ReleaseMode.stop);
    final imagesRef = storageRef.child(url);
    final downloadUrl = await imagesRef.getDownloadURL();
    await player.play(UrlSource(downloadUrl));
    emit(Playing());

    player.onPlayerComplete.listen((event) async {
      emit(Paused());
    });
  }

  void stop() async {
    await player.release();
    emit(NoFile());
  }

  void play() async {
    await player.resume();
    emit(Playing());
  }

  void pause() async {
    await player.pause();
    emit(Paused());
  }

  void replay() async {
    await player.seek(Duration.zero);
  }

  void goBack() async {
    final position = await player.getCurrentPosition();
    await player.seek(Duration(seconds: position!.inSeconds - 10));
  }

  void uploadFile(File file) async {
    String fileName = file.path.split('/').last;
    final fileRef = storageRef.child(fileName);
    await fileRef.putFile(file);
  }
}

abstract class FileCubitState {}

class Playing extends FileCubitState {}

class Paused extends FileCubitState {}

class NoFile extends FileCubitState {}
