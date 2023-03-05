import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dict/classes.dart';

class BeatCubit extends Cubit<BeatState> {
  BeatCubit() : super(InitState());

  late Beat beat;

  init() {
    beat = Beat([Note(duration: 1, pitch: 0)]);
    emit(BeatSetState());
  }

  double getAngle() {
    if (beat.notes[0].pitch < 12) {
      return pi;
    } else {
      return pi / 180;
    }
  }

  down() {
    if (beat.notes[0].pitch < 24) {
      beat.notes[0].pitch += 1;
    }

    emit(BeatSetState());
  }

  up() {
    if (beat.notes[0].pitch > 0) {
      beat.notes[0].pitch -= 1;
    }

    emit(BeatSetState());
  }
}

abstract class BeatState {}

class InitState extends BeatState {}

class BeatSetState extends BeatState {}
