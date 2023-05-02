import 'package:dict/util/notes_icons.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'classes.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class Note {
  Note({
    // 1 - 32
    required this.duration,

    // 0 - 24
    required this.pitch,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  int duration;
  int pitch;

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  IconData getNoteIcon() {
    switch (duration) {
      case 1:
        return Notes.whole;
      case 2:
        if (pitch > 12) {
          return Notes.half;
        } else {
          return Notes.halfReversed;
        }
      case 4:
        if (pitch > 12) {
          return Notes.quarter;
        } else {
          return Notes.quarterReversed;
        }
      case 8:
        if (pitch > 12) {
          return Notes.eight;
        } else {
          return Notes.eightReversed;
        }
      case 16:
        if (pitch > 12) {
          return Notes.sixteen;
        } else {
          return Notes.sixteenReversed;
        }
      default:
        return Notes.eight;
    }
  }
}

@JsonSerializable(explicitToJson: true)
class Beat {
  Beat(this.notes);

  factory Beat.fromJson(Map<String, dynamic> json) => _$BeatFromJson(json);
  Map<String, dynamic> toJson() => _$BeatToJson(this);

  List<Note> notes;
}

@JsonSerializable(explicitToJson: true)
class Dictando {
  Dictando({
    required this.beats,
    required this.name,
    this.isPrivate = true,
  });

  factory Dictando.parseDictando(Map<Object?, Object?> jsonMap) {
    String name = jsonMap['name'] as String;
    bool isPrivate = jsonMap['isPrivate'] as bool;
    List<dynamic> beatsJson = jsonMap['beats'] as List<dynamic>;
    List<Beat> beats = beatsJson.map((beatJson) {
      List<dynamic> notesJson = beatJson['notes'] as List<dynamic>;
      List<Note> notes = notesJson
          .map(
            (noteJson) => Note(
              duration: noteJson['duration'] as int,
              pitch: noteJson['pitch'] as int,
            ),
          )
          .toList();
      return Beat(notes);
    }).toList();
    return Dictando(beats: beats, name: name, isPrivate: isPrivate);
  }

  factory Dictando.fromJson(Map<String, dynamic> json) =>
      _$DictandoFromJson(json);
  Map<String, dynamic> toJson() => _$DictandoToJson(this);

  List<Beat> beats;
  String name;
  bool isPrivate;
}

class DictandoFromDatabase {
  DictandoFromDatabase({
    required this.dictando,
    required this.id,
  });
  Dictando dictando;
  String id;
}
