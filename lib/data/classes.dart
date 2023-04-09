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
  Dictando(this.beats);

  factory Dictando.fromJson(Map<String, dynamic> json) =>
      _$DictandoFromJson(json);
  Map<String, dynamic> toJson() => _$DictandoToJson(this);

  List<Beat> beats;
}
