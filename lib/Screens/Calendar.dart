import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:icalendar_parser/icalendar_parser.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Appointment> _appointments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSchedule();
  }

  Future<void> _fetchSchedule() async {
    try {
      final response = await http.get(Uri.https('ical.devinci.me', 'ical_student/32504db3f803d04a4c6ffb7d9266da6a'));

      if (response.statusCode == 200) {
        // Parse the iCalendar data
        final calendar = ICalendar.fromString(response.body);
        final events = calendar.data.where((event) => event['type'] == 'VEVENT');

        // Map iCalendar events to SfCalendar Appointments
        final List<Appointment> appointments = events.map((event) {
          // Convert `IcsDateTime` to `DateTime`
          final start = (event['dtstart'] as IcsDateTime).toDateTime();
          final end = (event['dtend'] as IcsDateTime).toDateTime();
          final subject = event['summary']?.toString() ?? 'Event';

          return Appointment(
            startTime: start!,
            endTime: end!,
            subject: subject,
            color: Colors.blueAccent,
          );
        }).toList();

        setState(() {
          _appointments = appointments;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load schedule');
      }
    } catch (error) {
      print('Error fetching schedule: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SfCalendar(
          backgroundColor: Colors.white,
          view: CalendarView.workWeek,
          firstDayOfWeek: 1,
          todayHighlightColor: Colors.orange,
          timeSlotViewSettings: const TimeSlotViewSettings(
            startHour: 8,
            endHour: 22,
            timeIntervalHeight: -1,
            timeFormat: 'HH:mm',
            nonWorkingDays: <int>[DateTime.sunday],
          ),
          dataSource: AppointmentDataSource(_appointments),
        ),
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}