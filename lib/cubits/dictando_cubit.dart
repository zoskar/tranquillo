import 'package:dict/util/notes_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/data/classes.dart';

class DictandoCubit extends Cubit<DictandoState> {
  DictandoCubit() : super(InitState());

  late Dictando dictando;
  late Beat beat;
  late int beatIndex;
  late int noteIndex;

  init() {
    dictando = Dictando(beats: [], name: 'Placeholder name');
    beat = Beat([Note(duration: 8, pitch: 12)]);
    noteIndex = 0;
    beatIndex = 0;
    emit(DictandoSetState());
  }

  setPitch(int pitch) {
    beat.notes[noteIndex].pitch = pitch;
    emit(DictandoSetState());
  }

  setDuration(int duration) {
    beat.notes[noteIndex].duration = duration;
    emit(DictandoSetState());
  }

  IconData noteAt(int i) {
    switch (beat.notes[i].duration) {
      case 1:
        return Notes.whole;
      case 2:
        return Notes.half;
      case 4:
        return Notes.quarter;
      case 8:
        return Notes.eight;
      case 16:
        return Notes.sixteen;
      default:
        return Notes.eight;
    }
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
    if (noteIndex < 6) {
      if (noteIndex == beat.notes.length - 1) {
        beat.notes.add(Note(duration: 8, pitch: 12));
      }
      noteIndex += 1;
    }
    emit(DictandoSetState());
  }

  beatRight() {
    if (beatIndex == dictando.beats.length) {
      addBeat();
    } else {
      beatIndex += 1;
      beat = dictando.beats[beatIndex];
    }
    emit(DictandoSetState());
  }

  noteLeft() {
    if (noteIndex > 0) {
      noteIndex -= 1;
    }
    emit(DictandoSetState());
  }

  beatLeft() {
    if (beatIndex > 0) {
      beatIndex -= 1;
      beat = dictando.beats[beatIndex];
    }
    emit(DictandoSetState());
  }

  deleteNote() {
    if (beat.notes.length > 1) {
      if (noteIndex == beat.notes.length - 1) {
        noteIndex -= 1;
        beat.notes.removeAt(noteIndex + 1);
      } else {
        beat.notes.removeAt(noteIndex);
      }
    }
    emit(DictandoSetState());
  }

  addBeat() {
    dictando.beats.add(beat);
    beat = Beat([Note(duration: 8, pitch: 12)]);
    beatIndex += 1;
    noteIndex = 0;
    emit(DictandoSetState());
  }

  clearDictando() {
    dictando = Dictando(beats: [], name: 'Placeholder name');
  }
}

abstract class DictandoState {}

class InitState extends DictandoState {}

class DictandoSetState extends DictandoState {}
