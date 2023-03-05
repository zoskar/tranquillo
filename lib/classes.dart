import 'dart:math';

class Note {
  Note({
    // 1 - 1/32
    required this.duration,

    // 0-24
    required this.pitch,
  });

  int duration;
  int pitch;

  double getAngle() {
    if (pitch <= 12) {
      return pi;
    } else {
      return pi / 180;
    }
  }
}

class Beat {
  Beat(this.notes);
  List<Note> notes;
}

class Dictando {
  Dictando(this.beats);
  List<Beat> beats;
}
