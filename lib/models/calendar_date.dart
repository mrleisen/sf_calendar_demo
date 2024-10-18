import 'package:flutter/material.dart';

enum CalendarDateStatusEnum {
  pending,
  completed,
  cancelled,
}
abstract class CalendarDate {
  String name;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  CalendarDateStatusEnum status;

  CalendarDate({
    required this.name,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
    required this.status,
  });

}

class CalendarDateEmpty extends CalendarDate {
  CalendarDateEmpty()
      : super(
          name: 'Empty CalendarDate',
          from: DateTime.now(),
          to: DateTime.now(),
          background: Colors.white,
          isAllDay: false,
          status: CalendarDateStatusEnum.completed,
        );


  @override
  String toString() {
    return 'Hello there, I am your father!'
        '\n'
        '\n You have to have these properties if you want to be my son:'
        ' \n    -name, which is a String'
        ' \n    -from, which is a DateTime'
        ' \n    -to, which is a DateTime too'
        ' \n    -background, which is a Color, also used for the event\'s status,'
        ' \n    -isAllDay, which is a bool'
        ' \n    -and status, which is an Enum'
        ' \n'
        ' \n I am a father, and I am proud of it!';
  }
}