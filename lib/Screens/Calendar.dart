import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sma/Utils/PreferencesManager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:uuid/uuid.dart';

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
          appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
            final Appointment appointment = details.appointments.first;
            return appointmentBuilder(
              context,
              details,
            );
          },
        ),
      ),
    );
  }
}

Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
     {
      bool tablet = false,
    }) {
  final Appointment event = details.appointments.first;
  late Color background;
  late Color textColor = Colors.white;
  textColor = Colors.black;
  background = PreferencesManager().accent;
  bool showSpeaker = true;
  String title = '';
  String type = '';
  title += event.subject;
  String location = '';

  location = 'none';
  const CalendarView currentView = CalendarView.workWeek;
  double titleMaxHeight =
      details.bounds.height - 26 - (type.isNotEmpty ? 14 : 0);
  if (currentView == CalendarView.day ||
      (currentView == CalendarView.week && tablet)) {
    titleMaxHeight = details.bounds.height - 40;
    if (details.bounds.height < 57) {
      showSpeaker = false;
    }
    if (details.bounds.height < 40) {
      location = '';
      showSpeaker = false;
    }
  } else if (currentView == CalendarView.month && tablet) {
    location = '';
    showSpeaker = false;
  }
  if (location.isEmpty) {
    titleMaxHeight = details.bounds.height - 8 - (type.isNotEmpty ? 14 : 0);
  }
  double titleFontSize = 12;
  if (currentView == CalendarView.day) {
    titleFontSize = 14;
  }
  double sizedBoxWidth =
      details.bounds.width - (10);
  if (currentView == CalendarView.day) {
    sizedBoxWidth = details.bounds.width - 16;
  }
  final double containerHeight = details.bounds.height;
  if (titleMaxHeight < 0) titleMaxHeight = 0;
  return Container(
    key: const Key('cours'),
    height: containerHeight,
    width: details.bounds.width,
    decoration: BoxDecoration(
      color: background.withOpacity(0.2),
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(5),
        right: Radius.circular(7),
      ),
    ),
    child: Row(
      children: [
          Container(
            width: 4,
            height: details.bounds.height,
            decoration: BoxDecoration(
              color: background,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(7),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: currentView == CalendarView.day ? 6 : 3,
          ),
          child: SizedBox(
            width: sizedBoxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (type.isNotEmpty)
                  AutoSizeText(
                    type,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    minFontSize: 2,
                    stepGranularity: 0.1,
                    style: TextStyle(
                      color: textColor,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: titleMaxHeight,
                  ),
                  child: AutoSizeText(
                    title,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.fade,
                    //softWrap: true,
                    style: TextStyle(
                      color: textColor,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                if (location.isNotEmpty)
                  AutoSizeText(
                    location,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    maxFontSize: 15,
                    minFontSize: 10,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                if (event.subject!.isNotEmpty &&
                    (currentView == CalendarView.day ||
                        (currentView == CalendarView.week && tablet)) &&
                    showSpeaker)
                  Text(
                    "Louis",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class CalEvent {
  CalEvent({
    required this.title,
    this.speaker,
    this.room,
    this.location,
    required this.from,
    required this.to,
    String? id,
    this.group,
    this.type = 'NR',
    this.notes,
  }) {
    if (id != null) {
      this.id = id;
    } else {
      this.id = const Uuid().v1();
    }
  }

  String title;

  String? speaker;

  String? room;

  String? location;

  DateTime from;

  DateTime to;

  late String id;

  String? group;

  String type;

  String? notes;

  @override
  bool operator ==(Object other) {
    if (other is! CalEvent) {
      return false;
    }
    return other.title == title &&
        other.speaker == speaker &&
        other.room == room &&
        other.location == location &&
        other.from == from &&
        other.to == to &&
        other.group == group &&
        other.type == type &&
        other.notes == notes;
  }

  @override
  int get hashCode => (title +
      (speaker ?? '') +
      (room ?? '') +
      (location ?? '') +
      from.toIso8601String() +
      to.toIso8601String())
      .hashCode;
}