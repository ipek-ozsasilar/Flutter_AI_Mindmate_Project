import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  /// FlutterLocalNotifications bildirim ID'si (integer) — Firestore'a alan olarak kaydedilir
  final int? notificationId;
  final String? date;
  final String? time;
  final String? title;
  final String? body;
  final bool? isRead;

  NotificationModel({
    this.notificationId,
    required this.date,
    required this.time,
    required this.title,
    required this.body,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props => [notificationId, date, time, title, body, isRead];

  NotificationModel copyWith({
    int? notificationId,
    String? date,
    String? time,
    String? title,
    String? body,
    bool? isRead,
  }) => NotificationModel(
    notificationId: notificationId ?? this.notificationId,
    date: date ?? this.date,
    time: time ?? this.time,
    title: title ?? this.title,
    body: body ?? this.body,
    isRead: isRead ?? this.isRead,
  );
}
