import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/data/classes.dart';

class DictandoCubit extends Cubit<DictandoState> {
  DictandoCubit() : super(InitState());

  late Dictando dictando;
  late Beat beat;
  late int beatIndex;
  late int noteIndex;

  init() {
    dictando = Dictando([]);
    beat = Beat([Note(duration: 1, pitch: 12)]);
    noteIndex = 0;
    beatIndex = 0;
    emit(DictandoSetState());
  }

  setPitch(int pitch) {
    beat.notes[noteIndex].pitch = pitch;
    emit(DictandoSetState());
  }

  noteDown() {
    if (beat.notes[noteIndex].pitch < 24) {
      beat.notes[noteIndex].pitch += 1;
    }

    emit(DictandoSetState());
  }

  noteUp() {
    if (beat.notes[noteIndex].pitch > 0) {
      beat.notes[noteIndex].pitch -= 1;
    }

    emit(DictandoSetState());
  }

  noteRight() {
    if (noteIndex < 3) {
      if (noteIndex == beat.notes.length - 1) {
        beat.notes.add(Note(duration: 1, pitch: 12));
      }
      noteIndex += 1;
    }

    emit(DictandoSetState());
  }

  noteLeft() {
    if (noteIndex > 0) {
      noteIndex -= 1;
    }

    emit(DictandoSetState());
  }

  deleteNote() {
    if (beat.notes.length > 1) {
      beat.notes.removeAt(noteIndex);
      if (noteIndex > 0) {
        noteIndex -= 1;
      }
    }

    emit(DictandoSetState());
  }

  addBeat() {
    dictando.beats.add(beat);
    emit(DictandoSetState());
  }
}

abstract class DictandoState {}

class InitState extends DictandoState {}

class DictandoSetState extends DictandoState {}
