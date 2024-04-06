import 'package:flutter/material.dart';

class TimeTransformer {
  static String toIso8601WithoutSeconds(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
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
