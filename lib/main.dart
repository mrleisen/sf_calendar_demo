import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalendarExample(),
    );
  }
}

class CalendarExample extends StatelessWidget {
  const CalendarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Calendar Example'),
      ),
      body: SfCalendar(
        view: CalendarView.day,
        dataSource: CustomDataSource(getCalendarData()),
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
        ),
        onTap: (CalendarTapDetails details) {
          if (details.appointments != null && details.appointments!.isNotEmpty) {
            final CalendarEvent event = details.appointments!.first;
            if (event is Meeting) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(event.eventName),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('From: ${event.from}'),
                        Text('To: ${event.to}'),
                        Text('Attendees: ${event.attendees.join(', ')}'),
                      ],
                    ),
                  );
                },
              );
            } else if (event is Event) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(event.eventName),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('From: ${event.from}'),
                        Text('To: ${event.to}'),
                        Text('Location: ${event.location}'),
                      ],
                    ),
                  );
                },
              );
            } else if (event is Timesheet) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(event.eventName),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('From: ${event.from}'),
                        Text('To: ${event.to}'),
                        Text('Total Hours: ${event.totalHours}'),
                        Text('Project: ${event.project}'),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}

List<CalendarEvent> getCalendarData() {
  return <CalendarEvent>[
    Meeting(
      eventName: 'Project Meeting',
      from: DateTime.now().add(const Duration(days: 1)),
      to: DateTime.now().add(const Duration(days: 1, hours: 1)),
      background: Colors.blue,
      isAllDay: false,
      attendees: ['John', 'Emily', 'Mark'],
    ),
    Event(
      eventName: 'Business Conference',
      from: DateTime.now().add(const Duration(days: 7)),
      to: DateTime.now().add(const Duration(days: 7, hours: 4)),
      background: Colors.red,
      isAllDay: true,
      location: 'Conference Hall 3',
    ),
    Timesheet(
      taskName: 'Work on Timesheet',
      from: DateTime.now().add(const Duration(days: 3, hours: 9)),
      to: DateTime.now().add(const Duration(days: 3, hours: 17)),
      background: Colors.green,
      totalHours: 8,
      project: 'Project A',
    ),
  ];
}

abstract class CalendarEvent {
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

  CalendarEvent({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
  });
}

class Meeting extends CalendarEvent {
  List<String> attendees;

  Meeting({
    required super.eventName,
    required super.from,
    required super.to,
    required super.background,
    required super.isAllDay,
    required this.attendees,
  });
}

class Event extends CalendarEvent {
  String location;

  Event({
    required super.eventName,
    required super.from,
    required super.to,
    required super.background,
    required super.isAllDay,
    required this.location,
  });
}

class Timesheet extends CalendarEvent {
  int totalHours;
  String project;

  Timesheet({
    required String taskName,
    required super.from,
    required super.to,
    required super.background,
    required this.totalHours,
    required this.project,
  }) : super(
    eventName: taskName,
    isAllDay: false,
  );
}

class CustomDataSource extends CalendarDataSource {
  CustomDataSource(List<CalendarEvent> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
