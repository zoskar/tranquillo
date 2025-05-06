import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquillo/data/classes.dart';

/// DictandoCubit is responsible for creating and editing dictandos
class DictandoCubit extends Cubit<DictandoState> {
  DictandoCubit() : super(InitState());

  late Dictando dictando;
  late Dictando dictandoBis;
  late int barIndex;
  late int noteIndex;
  final CarouselController carouselController = CarouselController();
  String dictandoId = '';

  /// Initializes the cubit with a placeholder dictando
  void init() {
    dictando = dictandoBis = Dictando(
      bars: [
        Bar([Note(duration: 8, pitch: 14)]),
      ],
      name: '',
    );

    noteIndex = 0;
    barIndex = 0;
    emit(DictandoSetState());
  }

  /// Sets the cubit with a dictando from the database
  void editDictando(Dictando editDictando, String editDictandoId) {
    dictando = editDictando;
    barIndex = 0;
    noteIndex = dictando.bars[barIndex].notes.length - 1;
    dictandoId = editDictandoId;
    emit(DictandoSetState());
  }

  void compareDictando(Dictando dictando, Dictando dictandoBis) {
    this.dictando = dictando;
    this.dictandoBis = dictandoBis;
    barIndex = 0;
    noteIndex = 0;
    emit(DictandoSetState());
  }

  /// Sets pitch of the current note
  void setPitch(int pitch) {
    dictando.bars[barIndex].notes[noteIndex].pitch = pitch;
    emit(DictandoSetState());
  }

  /// Sets duration of the current note
  void setDuration(int duration) {
    dictando.bars[barIndex].notes[noteIndex].duration = duration;
    emit(DictandoSetState());
  }

  /// Reduces pitch of the current note
  void noteDown() {
    if (dictando.bars[barIndex].notes[noteIndex].pitch < 24) {
      dictando.bars[barIndex].notes[noteIndex].pitch += 1;
    }
    emit(DictandoSetState());
  }

  /// Increases pitch of the current note
  void noteUp() {
    if (dictando.bars[barIndex].notes[noteIndex].pitch > 0) {
      dictando.bars[barIndex].notes[noteIndex].pitch -= 1;
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
      if (noteIndex == dictando.bars[barIndex].notes.length - 1) {
        dictando.bars[barIndex].notes.add(Note(duration: 8, pitch: 14));
      }
      noteIndex += 1;
    }
    emit(DictandoSetState());
  }

  /// Chenges current bar to the left
  void barLeft() {
    if (barIndex > 0) {
      barIndex -= 1;
      noteIndex = 0;
      carouselController.animateToPage(barIndex);
      emit(DictandoSetState());
    }
  }

  void barLeftCompare() {
    /// Not on last bar of any dictando
    if (barIndex > 0) {
      barIndex -= 1;
    }
    emit(DictandoSetState());
  }

  /// Chenges current bar to the right
  void barRight({bool preview = false}) {
    if (barIndex == dictando.bars.length - 1 && !preview) {
      dictando.bars.add(Bar([Note(duration: 8, pitch: 14)]));
    }

    /// Not on last bar
    if (!(barIndex == dictando.bars.length - 1)) {
      barIndex += 1;
    }
    noteIndex = 0;
    carouselController.animateToPage(barIndex);
    emit(DictandoSetState());
  }

  /// Chenges current bar to the right
  void barRightCompare() {
    /// Not on last bar of any dictando

    if (!(barIndex == dictando.bars.length - 1 ||
        barIndex == dictandoBis.bars.length - 1)) {
      barIndex += 1;
    }
    emit(DictandoSetState());
  }

  /// Deletes current note
  void deleteNote() {
    if (dictando.bars[barIndex].notes.length > 1) {
      if (noteIndex == dictando.bars[barIndex].notes.length - 1) {
        noteIndex -= 1;
        dictando.bars[barIndex].notes.removeAt(noteIndex + 1);
      } else {
        dictando.bars[barIndex].notes.removeAt(noteIndex);
      }
    }
    emit(DictandoSetState());
  }

  /// Jumps to the bar with the given index
  void changeBar(int index) {
    barIndex = index;
    emit(DictandoSetState());
  }

  /// Clears dictando cubit
  void clearDictando() {
    dictando = Dictando(bars: [], name: 'Placeholder name');
    emit(InitState());
  }
}

abstract class DictandoState {}

class InitState extends DictandoState {}

class DictandoSetState extends DictandoState {}
