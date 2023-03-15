class Note {
  Note({
    // 1 - 1/32
    required this.duration,

    // 0-24
    required this.pitch,
  });

  int duration;
  int pitch;
}

class Beat {
  Beat(this.notes);
  List<Note> notes;
}

class Dictando {
  Dictando(this.beats);
  List<Beat> beats;
}
