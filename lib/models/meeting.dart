import 'package:flutter/material.dart';
import 'package:sf_calendar_demo/models/calendar_date.dart';

class Meeting extends CalendarDate {
  List<String> attendees;

  Meeting({
    required super.name,
    required super.from,
    required super.to,
    required super.background,
    required super.isAllDay,
    required super.status,
    required this.attendees,
  });

  @override
  String toString() {
    return 'Hello there, I am a Meeting!'
        'My parent is a CalendarDate, so I have the same properties as him.'
        ' \n But because I am a Meeting, I also have:'
        ' \n -attendees, which is a List<String>'
        ' \n'
        ' \n Wait! I\'m not another boring Meeting!';
  }

  static empty() {
    return Meeting(
      name: 'Empty Meeting',
      from: DateTime.now(),
      to: DateTime.now(),
      background: Colors.white,
      isAllDay: false,
      status: CalendarDateStatusEnum.completed,
      attendees: ['Unknown'],
    );
  }

}