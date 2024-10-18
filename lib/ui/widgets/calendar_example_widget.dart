import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:sf_calendar_demo/ui/datasources/custom_data_source.dart';
import 'package:sf_calendar_demo/models/calendar_date.dart';
import 'package:sf_calendar_demo/models/event.dart';
import 'package:sf_calendar_demo/models/meeting.dart';
import 'package:sf_calendar_demo/models/time_sheet.dart';

class CalendarExample extends StatefulWidget {
  const CalendarExample({
    required this.calendarDataSource,
    super.key});

  final List<CalendarDate> calendarDataSource;

  @override
  State<CalendarExample> createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {

  late CalendarView _calendarView;
  List<CalendarDate> _calendarDataSource = [];
  late CalendarController _calendarController;

  @override
  void initState() {
    _calendarDataSource = List.from(widget.calendarDataSource);
    _calendarView = CalendarView.month;
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Calendar Example'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: _calendarView == CalendarView.month ? Colors.blue : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.month;
                      _calendarController.view = _calendarView;
                    });
                  },
                  child: const Text('Month'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: _calendarView == CalendarView.week ? Colors.blue : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.week;
                      _calendarController.view = _calendarView;
                    });
                  },
                  child: const Text('Week'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: _calendarView == CalendarView.day ? Colors.blue : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.day;
                      _calendarController.view = _calendarView;
                    });
                  },
                  child: const Text('Day'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: _calendarView == CalendarView.timelineMonth ? Colors.blue : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.timelineMonth;
                      _calendarController.view = _calendarView;
                    });
                  },
                  child: const Text('Timeline Month'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: _calendarView == CalendarView.timelineWeek ? Colors.blue : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.timelineWeek;
                      _calendarController.view = _calendarView;
                    });
                  },
                  child: const Text('Timeline Week'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: _calendarView == CalendarView.day ? Colors.blue : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _calendarView = CalendarView.timelineDay;
                      _calendarController.view = _calendarView;
                    });
                  },
                  child: const Text('Timeline Day'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SfCalendar(
              timeSlotViewSettings: const TimeSlotViewSettings(
                timeIntervalHeight: 80,
                timeIntervalWidth: 100
              ),
              controller: _calendarController,
              view: _calendarView,
              dataSource: CustomDataSource(_calendarDataSource),
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
              appointmentBuilder: _appointmentBuilder,
              onTap: _onTap,
            ),
          ),
          Container(
            height: 50,
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Tooltip(
                  padding: const EdgeInsets.all(8.0),
                  message: '${Event.empty()}',
                  child: const Text('Event'),
                ),
                Tooltip(
                  padding: const EdgeInsets.all(8.0),
                  message: '${Meeting.empty()}',
                  child: const Text('Meeting'),
                ),
                Tooltip(
                  padding: const EdgeInsets.all(8.0),
                  message: '${Timesheet.empty()}',
                  child: const Text('Timesheet'),
                ),
                Tooltip(
                  padding: const EdgeInsets.all(8.0),
                  message: '${CalendarDateEmpty()}',
                  child: const Text('CalendarDate'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(CalendarTapDetails details) {
    if (details.appointments != null && details.appointments!.isNotEmpty) {
      final CalendarDate event = details.appointments!.first;
      if (event is Meeting) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(event.name),
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
              title: Text(event.name),
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
              title: Text(event.name),
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
  }

  Widget _appointmentBuilder(BuildContext context, CalendarAppointmentDetails calendarAppointmentDetails) {
    final CalendarDate event = calendarAppointmentDetails.appointments.first;
    if(_calendarView == CalendarView.month) {
      return Card(
        margin: const EdgeInsets.all(0),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              width: 5,
              color: event.background,
            ),
            Text(
              event.name,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 50,
        decoration: BoxDecoration(
          color: event.background,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // widget to display the status
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        _getStatusString(event.status),
                        style: TextStyle(color: event.background),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // text widget to display the date name
                  Flexible(
                    child: Text(
                      event.name,
                      style: const TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  String _getStatusString(CalendarDateStatusEnum status) {
    switch (status) {
      case CalendarDateStatusEnum.pending:
        return 'Pending';
      case CalendarDateStatusEnum.completed:
        return 'Completed';
      case CalendarDateStatusEnum.cancelled:
        return 'Cancelled';
    }
  }
}