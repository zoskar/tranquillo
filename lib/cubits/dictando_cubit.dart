import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/data/classes.dart';

/// DictandoCubit is responsible for creating and editing dictandos
class DictandoCubit extends Cubit<DictandoState> {
  DictandoCubit() : super(InitState());

  late Dictando dictando;
  late int beatIndex;
  late int noteIndex;
  final CarouselController carouselController = CarouselController();

  init() {
    dictando = Dictando(
      beats: [
        Beat([Note(duration: 8, pitch: 14)])
      ],
      name: 'Placeholder name',
    );
    noteIndex = 0;
    beatIndex = 0;
    emit(DictandoSetState());
  }

  setPitch(int pitch) {
    dictando.beats[beatIndex].notes[noteIndex].pitch = pitch;
    emit(DictandoSetState());
  }

  setDuration(int duration) {
    dictando.beats[beatIndex].notes[noteIndex].duration = duration;
    emit(DictandoSetState());
  }

  noteDown() {
    if (dictando.beats[beatIndex].notes[noteIndex].pitch < 24) {
      dictando.beats[beatIndex].notes[noteIndex].pitch += 1;
    }
    emit(DictandoSetState());
  }

  noteUp() {
    if (dictando.beats[beatIndex].notes[noteIndex].pitch > 0) {
      dictando.beats[beatIndex].notes[noteIndex].pitch -= 1;
    }
    emit(DictandoSetState());
  }

  noteLeft() {
    if (noteIndex > 0) {
      noteIndex -= 1;
    }
    emit(DictandoSetState());
  }

  noteRight() {
    if (noteIndex < 12) {
      if (noteIndex == dictando.beats[beatIndex].notes.length - 1) {
        dictando.beats[beatIndex].notes.add(Note(duration: 8, pitch: 14));
      }
      noteIndex += 1;
    }
    emit(DictandoSetState());
  }

  beatLeft() {
    if (beatIndex > 0) {
      beatIndex -= 1;
      noteIndex = 0;
      carouselController.animateToPage(beatIndex);
      emit(DictandoSetState());
    }
  }

  beatRight() {
    if (beatIndex == dictando.beats.length - 1) {
      dictando.beats.add(Beat([Note(duration: 8, pitch: 14)]));
    }
    beatIndex += 1;
    noteIndex = 0;
    carouselController.animateToPage(beatIndex);
    emit(DictandoSetState());
  }

  deleteNote() {
    if (dictando.beats[beatIndex].notes.length > 1) {
      if (noteIndex == dictando.beats[beatIndex].notes.length - 1) {
        noteIndex -= 1;
        dictando.beats[beatIndex].notes.removeAt(noteIndex + 1);
      } else {
        dictando.beats[beatIndex].notes.removeAt(noteIndex);
      }
    }
    emit(DictandoSetState());
  }

  changeBeat(int index) {
    beatIndex = index;
    emit(DictandoSetState());
  }

  clearDictando() {
    dictando = Dictando(beats: [], name: 'Placeholder name');
  }
}

abstract class DictandoState {}

class InitState extends DictandoState {}

class DictandoSetState extends DictandoState {}
