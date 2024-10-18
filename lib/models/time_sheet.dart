import 'package:flutter/material.dart';
import 'package:sf_calendar_demo/models/calendar_date.dart';

class Timesheet extends CalendarDate {
  int totalHours;
  String project;

  Timesheet({
    required String taskName,
    required super.from,
    required super.to,
    required super.background,
    required super.status,
    required this.totalHours,
    required this.project,
  }) : super(
    name: taskName,
    isAllDay: false,
  );

  @override
  String toString() {
    return 'Hello there, I am a Timesheet!'
        'My father is a CalendarDate, so you know how it goes.'
        ' \n'
        ' \n But because I am a Timesheet, I also have:'
        ' \n -totalHours, which is an int'
        ' \n -project, which is a String'
        ' \n'
        ' \n Tbh I\'m not sure what I am doing here! Do you?';
  }

  static empty() {
    return Timesheet(
      taskName: 'Empty Timesheet',
      from: DateTime.now(),
      to: DateTime.now(),
      background: Colors.white,
      status: CalendarDateStatusEnum.completed,
      totalHours: 0,
      project: 'Unknown',
    );
  }

}