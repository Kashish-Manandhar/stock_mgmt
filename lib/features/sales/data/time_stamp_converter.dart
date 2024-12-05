import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimeStampConverter extends JsonConverter<DateTime, Timestamp> {
  const TimeStampConverter();
  @override
  DateTime fromJson(Timestamp json) {
    return DateTime.fromMillisecondsSinceEpoch(json.millisecondsSinceEpoch);
  }

  @override
  Timestamp toJson(DateTime object) =>
      Timestamp.fromMillisecondsSinceEpoch(object.millisecondsSinceEpoch);
}
