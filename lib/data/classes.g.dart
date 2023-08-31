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

Bar _$BarFromJson(Map<String, dynamic> json) => Bar(
      (json['notes'] as List<dynamic>)
          .map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BarToJson(Bar instance) => <String, dynamic>{
      'notes': instance.notes.map((e) => e.toJson()).toList(),
    };

Dictando _$DictandoFromJson(Map<String, dynamic> json) => Dictando(
      bars: (json['bars'] as List<dynamic>)
          .map((e) => Bar.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      isPrivate: json['isPrivate'] as bool? ?? true,
    );

Map<String, dynamic> _$DictandoToJson(Dictando instance) => <String, dynamic>{
      'bars': instance.bars.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'isPrivate': instance.isPrivate,
    };
