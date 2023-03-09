import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/classes.dart';

class BeatCubit extends Cubit<BeatState> {
  BeatCubit() : super(InitState());

  late Beat beat;
  late int index;

  init() {
    beat = Beat([Note(duration: 1, pitch: 14)]);
    index = 0;
    emit(BeatSetState());
  }

  down() {
    if (beat.notes[index].pitch < 24) {
      beat.notes[index].pitch += 1;
    }

    emit(BeatSetState());
  }

  up() {
    if (beat.notes[index].pitch > 0) {
      beat.notes[index].pitch -= 1;
    }

    emit(BeatSetState());
  }

  right() {
    if (index < 3) {
      if (index == beat.notes.length - 1) {
        beat.notes.add(Note(duration: 1, pitch: 12));
      }
      index += 1;
    }

    emit(BeatSetState());
  }

  left() {
    if (index > 0) {
      index -= 1;
    }

    emit(BeatSetState());
  }

  delete() {
    if (beat.notes.length > 1) {
      beat.notes.removeAt(index);
      if (index > 0) {
        index -= 1;
      }
    }

    emit(BeatSetState());
  }
}

abstract class BeatState {}

class InitState extends BeatState {}

class BeatSetState extends BeatState {}
