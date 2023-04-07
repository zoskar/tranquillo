// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      duration: json['duration'] as int,
      pitch: json['pitch'] as int,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'duration': instance.duration,
      'pitch': instance.pitch,
    };

Beat _$BeatFromJson(Map<String, dynamic> json) => Beat(
      (json['notes'] as List<dynamic>)
          .map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BeatToJson(Beat instance) => <String, dynamic>{
      'notes': instance.notes.map((e) => e.toJson()).toList(),
    };

Dictando _$DictandoFromJson(Map<String, dynamic> json) => Dictando(
      (json['beats'] as List<dynamic>)
          .map((e) => Beat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DictandoToJson(Dictando instance) => <String, dynamic>{
      'beats': instance.beats.map((e) => e.toJson()).toList(),
    };
