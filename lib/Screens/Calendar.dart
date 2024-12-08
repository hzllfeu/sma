import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:sma/Utils/AppointmentManager.dart';
import 'package:sma/Utils/AppointmentModel.dart';
import 'package:sma/Utils/PopupMessage.dart';
import 'package:sma/Utils/PreferencesManager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:uuid/uuid.dart';

import '../Components/CalandarCard.dart';
import '../Utils/DatabaseManager.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  bool _isLoading = false;
  late final AppointmentManager _appointmentManager;


  @override
  void initState() {
    super.initState();
    _appointmentManager = AppointmentManager();

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : SfCalendar(
          backgroundColor: const Color(0xFFFFFAFA),
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
          headerStyle: const CalendarHeaderStyle(
            backgroundColor: Color(0xFFFFFAFA),
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            textAlign: TextAlign.center
          ),
          dataSource: _appointmentManager.getDataSource(),
          appointmentBuilder: (context, details) {
            return appointmentBuilder(context, details);
          },
          onTap: (CalendarTapDetails details) {
            onCalendarTapped(details, context);
          },
        ),
      ),
    );
  }

  void onCalendarTapped(
      CalendarTapDetails calendarTapDetails,
      BuildContext context,
      ) {
    if (calendarTapDetails.targetElement == CalendarElement.header) {
      return;
    }

    if (calendarTapDetails.appointments != null && calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Appointment tappedAppointment = calendarTapDetails.appointments!.first as Appointment;
      final AppointmentModel appointment = AppointmentManager().getDataSource().getAppointmentModel(tappedAppointment);

      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        context: context,
        builder: (context) => SafeArea(
          child: Wrap(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Gap(20),
                    Text(appointment.title, style: TextStyle(color: Colors.black, fontSize: 24),),
                    const Gap(20),
                    Text(appointment.speaker, style: TextStyle(color: Colors.black, fontSize: 24),),
                    const Gap(20),
                    Text(appointment.location, style: TextStyle(color: Colors.black, fontSize: 24),),
                    const Gap(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}


