import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends Equatable {
  final String? date;
  final String? period;
  final String? time;
  final String? userMessage;
  final String? aiResponse;
  final String? emoji;

  MessageModel({
    required this.date,
    required this.period,
    required this.time,
    required this.userMessage,
    required this.aiResponse,
    required this.emoji,
  });

  // JSON'dan (örneğin Firestore'dan) Message objesi oluşturur
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
  
  @override
  // TODO: implement props
  List<Object?> get props => [date, period, time, userMessage, aiResponse, emoji];

  MessageModel copyWith({
    String? date,
    String? period,
    String? time,
    String? userMessage,
    String? aiResponse,
    String? emoji,
  }) => MessageModel(date: date ?? this.date, period: period ?? this.period, time: time ?? this.time, userMessage: userMessage ?? this.userMessage, aiResponse: aiResponse ?? this.aiResponse, emoji: emoji ?? this.emoji);

}
