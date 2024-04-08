import 'package:flutter/material.dart';

class TimeTransformer {
  static String toIso8601WithoutSeconds(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static String toFullIso8601(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month >= 10 ? dateTime.month : '0${dateTime.month}'}-${dateTime.day >= 10 ? dateTime.day : '0${dateTime.day}'}T${dateTime.hour >= 10 ? dateTime.hour - 2 : '0${dateTime.hour - 2}'}:${dateTime.minute >= 10 ? dateTime.minute : '0${dateTime.minute}'}:${dateTime.second >= 10 ? dateTime.second : '0${dateTime.second}'}Z';
  }

  static TimeOfDay addTime(TimeOfDay timeOfDay, Duration duration) {
    final DateTime newDateTime =
        DateTime(0, 0, 0, timeOfDay.hour, timeOfDay.minute).add(duration);
    return TimeOfDay(hour: newDateTime.hour, minute: newDateTime.minute);
  }

  static TimeOfDay diffTime(TimeOfDay timeOfDay, Duration duration) {
    final DateTime newDateTime =
        DateTime(0, 0, 0, timeOfDay.hour, timeOfDay.minute).subtract(duration);
    return TimeOfDay(hour: newDateTime.hour, minute: newDateTime.minute);
  }
}
