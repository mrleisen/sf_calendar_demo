import 'package:flutter/material.dart';
import 'package:sf_calendar_demo/models/calendar_date.dart';
import 'package:sf_calendar_demo/models/event.dart';
import 'package:sf_calendar_demo/models/meeting.dart';
import 'package:sf_calendar_demo/models/time_sheet.dart';

import 'package:sf_calendar_demo/ui/widgets/calendar_example_widget.dart';
import 'package:sf_calendar_demo/data/calendar_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late CalendarRepository _calendarRepository;

  @override
  void initState() {
    _calendarRepository = CalendarRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion Calendar Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Material(
        child: FutureBuilder(
          future: _calendarRepository.getCalendarDates(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CalendarExample(calendarDataSource: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

}
