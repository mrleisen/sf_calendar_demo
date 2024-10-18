import 'package:flutter/material.dart';
import 'package:sf_calendar_demo/models/calendar_date.dart';

class Event extends CalendarDate {
  String location;

  Event({
    required super.name,
    required super.from,
    required super.to,
    required super.background,
    required super.isAllDay,
    required super.status,
    required this.location,
  });

  @override
  String toString() {
    return 'Hello there, I am an Event!'
        '\n'
        '\n I have the same properties as a CalendarDate.'
        ' \n But because I am an Event, I also have:'
        ' \n -location, which is a String'
        ' \n'
        ' \n I\'m such a special Event!';
  }

  static empty() {
    return Event(
      name: 'Empty Event',
      from: DateTime.now(),
      to: DateTime.now(),
      background: Colors.white,
      isAllDay: false,
      status: CalendarDateStatusEnum.completed,
      location: 'Unknown',
    );
  }
}