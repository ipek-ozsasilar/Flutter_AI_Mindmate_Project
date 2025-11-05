// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      notificationId: json['notificationId'] as int?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'date': instance.date,
      'time': instance.time,
      'title': instance.title,
      'body': instance.body,
      'isRead': instance.isRead,
    };
