// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
  date: json['date'] as String?,
  period: json['period'] as String?,
  time: json['time'] as String?,
  userMessage: json['userMessage'] as String?,
  aiResponse: json['aiResponse'] as String?,
  emoji: json['emoji'] as String?,
);

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'period': instance.period,
      'time': instance.time,
      'userMessage': instance.userMessage,
      'aiResponse': instance.aiResponse,
      'emoji': instance.emoji,
    };
