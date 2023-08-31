// ignore_for_file: avoid_dynamic_calls

import 'package:tranquillo/util/notes_icons.dart';
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
      case -1:
        return Notes.whole_pause;
      case 2:
        if (pitch > 12) {
          return Notes.half;
        } else {
          return Notes.half_reversed;
        }
      case -2:
        return Notes.half_pause;
      case 4:
        if (pitch > 12) {
          return Notes.quarter;
        } else {
          return Notes.quarter_reversed;
        }
      case -4:
        return Notes.quarter_pause;
      case 8:
        if (pitch > 12) {
          return Notes.eight;
        } else {
          return Notes.eight_reversed;
        }
      case -8:
        return Notes.eight_pause;
      case 16:
        if (pitch > 12) {
          return Notes.sixteen;
        } else {
          return Notes.sixteen_reversed;
        }
      case -16:
        return Notes.sixteen_pause;
      default:
        return Notes.eight;
    }
  }
}

@JsonSerializable(explicitToJson: true)
class Bar {
  Bar(this.notes);

  factory Bar.fromJson(Map<String, dynamic> json) => _$BarFromJson(json);
  Map<String, dynamic> toJson() => _$BarToJson(this);

  List<Note> notes;
}

@JsonSerializable(explicitToJson: true)
class Dictando {
  Dictando({
    required this.bars,
    required this.name,
    this.isPrivate = true,
  });

  factory Dictando.parseDictando(Map<Object?, Object?> jsonMap) {
    String name = jsonMap['name'] as String;
    List<dynamic> barJson = jsonMap['bars'] as List<dynamic>;
    List<Bar> bars = barJson.map((barJson) {
      List<dynamic> notesJson = barJson['notes'] as List<dynamic>;
      List<Note> notes = notesJson
          .map(
            (noteJson) => Note(
              duration: noteJson['duration'] as int,
              pitch: noteJson['pitch'] as int,
            ),
          )
          .toList();
      return Bar(notes);
    }).toList();
    return Dictando(bars: bars, name: name);
  }

  factory Dictando.fromJson(Map<String, dynamic> json) =>
      _$DictandoFromJson(json);
  Map<String, dynamic> toJson() => _$DictandoToJson(this);

  List<Bar> bars;
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
