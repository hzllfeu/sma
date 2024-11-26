import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sma/Utils/PopupMessage.dart';
import 'package:sma/Utils/PreferencesManager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class Calendar extends StatefulWidget {
  const Calendar({super.key});


  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xFFFFFAFA),
        body: SafeArea(
          child: SfCalendar(
            backgroundColor: const Color(0xFFFBFFFE),
            view: CalendarView.workWeek,
            firstDayOfWeek: 1,
            todayHighlightColor: PreferencesManager().accent,
            timeSlotViewSettings: const TimeSlotViewSettings(
              startHour: 8,
              endHour: 22,
              timeIntervalHeight: 48,
              timeFormat: 'HH:mm',
              nonWorkingDays: <int>[DateTime.sunday],
              // currentTimeIndicatorColor: Colors.orange,
            ),
          ),
        )
    );
  }
}
