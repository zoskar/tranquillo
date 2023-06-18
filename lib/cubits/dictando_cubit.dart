import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquillo/data/classes.dart';

/// DictandoCubit is responsible for creating and editing dictandos
class DictandoCubit extends Cubit<DictandoState> {
  DictandoCubit() : super(InitState());

  late Dictando dictando;
  late Dictando dictandoB;
  late int beatIndex;
  late int noteIndex;
  final CarouselController carouselController = CarouselController();
  String dictandoId = '';

  /// Initializes the cubit with a placeholder dictando
  void init() {
    dictando = dictandoB = Dictando(
      beats: [
        Beat([Note(duration: 8, pitch: 14)])
      ],
      name: '',
    );

    noteIndex = 0;
    beatIndex = 0;
    emit(DictandoSetState());
  }

  /// Sets the cubit with a dictando from the database
  void editDictando(Dictando editDictando, String editDictandoId) {
    dictando = editDictando;
    beatIndex = 0;
    noteIndex = dictando.beats[beatIndex].notes.length - 1;
    dictandoId = editDictandoId;
    emit(DictandoSetState());
  }

  void compareDictando(Dictando dictando, Dictando dictandoB) {
    this.dictando = dictando;
    this.dictandoB = dictandoB;
    beatIndex = 0;
    noteIndex = 0;
    emit(DictandoSetState());
  }

  /// Sets pitch of the current note
  void setPitch(int pitch) {
    dictando.beats[beatIndex].notes[noteIndex].pitch = pitch;
    emit(DictandoSetState());
  }

  /// Sets duration of the current note
  void setDuration(int duration) {
    dictando.beats[beatIndex].notes[noteIndex].duration = duration;
    emit(DictandoSetState());
  }

  /// Reduces pitch of the current note
  void noteDown() {
    if (dictando.beats[beatIndex].notes[noteIndex].pitch < 24) {
      dictando.beats[beatIndex].notes[noteIndex].pitch += 1;
    }
    emit(DictandoSetState());
  }

  /// Increases pitch of the current note
  void noteUp() {
    if (dictando.beats[beatIndex].notes[noteIndex].pitch > 0) {
      dictando.beats[beatIndex].notes[noteIndex].pitch -= 1;
    }
    emit(DictandoSetState());
  }

  /// Chenges current note to the left
  void noteLeft() {
    if (noteIndex > 0) {
      noteIndex -= 1;
    }
    emit(DictandoSetState());
  }

  /// Chenges current note to the right
  void noteRight() {
    if (noteIndex < 12) {
      if (noteIndex == dictando.beats[beatIndex].notes.length - 1) {
        dictando.beats[beatIndex].notes.add(Note(duration: 8, pitch: 14));
      }
      noteIndex += 1;
    }
    emit(DictandoSetState());
  }

  /// Chenges current beat to the left
  void beatLeft() {
    if (beatIndex > 0) {
      beatIndex -= 1;
      noteIndex = 0;
      carouselController.animateToPage(beatIndex);
      emit(DictandoSetState());
    }
  }

  void beatLeftCompare() {
    /// Not on last beat of any dictando
    if (beatIndex > 0) {
      beatIndex -= 1;
    }
    emit(DictandoSetState());
  }

  /// Chenges current beat to the right
  void beatRight({bool preview = false}) {
    if (beatIndex == dictando.beats.length - 1 && !preview) {
      dictando.beats.add(Beat([Note(duration: 8, pitch: 14)]));
    }

    /// Not on last beat
    if (!(beatIndex == dictando.beats.length - 1)) {
      beatIndex += 1;
    }
    noteIndex = 0;
    carouselController.animateToPage(beatIndex);
    emit(DictandoSetState());
  }

  /// Chenges current beat to the right
  void beatRightCompare() {
    /// Not on last beat of any dictando

    if (!(beatIndex == dictando.beats.length - 1 ||
        beatIndex == dictandoB.beats.length - 1)) {
      beatIndex += 1;
    }
    emit(DictandoSetState());
  }

  /// Deletes current note
  void deleteNote() {
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

  /// Jumps to the beat with the given index
  void changeBeat(int index) {
    beatIndex = index;
    emit(DictandoSetState());
  }

  /// Clears dictando cubit
  void clearDictando() {
    dictando = Dictando(beats: [], name: 'Placeholder name');
    emit(InitState());
  }
}

abstract class DictandoState {}

class InitState extends DictandoState {}

class DictandoSetState extends DictandoState {}
