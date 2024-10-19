import 'package:flutter/material.dart';

import 'package:sf_calendar_demo/models/calendar_date.dart';
import 'package:sf_calendar_demo/models/event.dart';
import 'package:sf_calendar_demo/models/meeting.dart';
import 'package:sf_calendar_demo/models/time_sheet.dart';

abstract class CalendarRepository {
  Future<List<CalendarDate>> getCalendarDates();
}

class CalendarRepositoryImpl extends CalendarRepository {

  @override
  Future<List<CalendarDate>> getCalendarDates() async {

    return <CalendarDate>[
      Event(
        name: 'Birthday Party',
        from: DateTime.now().add(const Duration(days: -3, hours: -4)),
        to: DateTime.now().add(const Duration(days: -3, hours: -1)),
        background: Colors.red,
        isAllDay: false,
        status: CalendarDateStatusEnum.completed,
        location: 'Paris',
      ),
      // event the same day
      Event(
        name: 'Wedding',
        from: DateTime.now().add(const Duration(days: -3, hours: -1)),
        to: DateTime.now().add(const Duration(days: -3, hours: 1)),
        background: Colors.purple,
        isAllDay: false,
        status: CalendarDateStatusEnum.pending,
        location: 'London',
      ),
      Meeting(
        name: 'Project Meeting',
        from: DateTime.now().add(const Duration(days: 1, hours: -6)),
        to: DateTime.now().add(const Duration(days: 1, hours: -5)),
        background: Colors.blue,
        isAllDay: false,
        status: CalendarDateStatusEnum.pending,
        attendees: ['John', 'Emily', 'Mark'],
      ),
      Timesheet(
        taskName: 'Work on Timesheet',
        from: DateTime.now().add(const Duration(days: -9, hours: -7)),
        to: DateTime.now().add(const Duration(days: -9, hours: -5)),
        background: Colors.green,
        status: CalendarDateStatusEnum.cancelled,
        totalHours: 8,
        project: 'Project A',
      ),
      // evento today at 10:00
      Meeting(
        name: 'Meeting with the boss',
        from: DateTime.now().add(const Duration(hours: 10)),
        to: DateTime.now().add(const Duration(hours: 11)),
        background: Colors.orange,
        isAllDay: false,
        status: CalendarDateStatusEnum.pending,
        attendees: ['Boss', 'Me'],
      ),
      // all day event
      Event(
        name: 'Conference',
        from: DateTime(2024, 10, 20, 0, 0),
        to: DateTime(2024, 10, 23, 23, 59),
        background: Colors.yellow,
        isAllDay: true,
        status: CalendarDateStatusEnum.pending,
        location: 'Las Vegas',
      ),
    ];
  }
}