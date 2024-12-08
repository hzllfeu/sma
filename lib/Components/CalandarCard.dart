import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../Utils/AppointmentManager.dart';
import '../Utils/AppointmentModel.dart';
import '../Utils/PreferencesManager.dart';

Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
    {
      bool tablet = false,
    }) {
  final Appointment tappedAppointment = details.appointments!.first as Appointment;
  final AppointmentModel event = AppointmentManager().getDataSource().getAppointmentModel(tappedAppointment);
  late Color background;
  late Color textColor = Colors.white;
  textColor = Colors.black;
  if(event.location == "ZOOM"){
    background = PreferencesManager().secondary;
  } else {
    background = PreferencesManager().accent;
  }
  bool showSpeaker = true;
  String title = '';
  String type = '';
  title += event.title;
  String location = '';

  location = '${event.location!}';
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
      details.bounds.width - 10;
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
            vertical: 4,
            horizontal: currentView == CalendarView.day ? 6 : 3,
          ),
          child: SizedBox(
            width: sizedBoxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    maxFontSize: 13,
                    minFontSize: 10,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                if (event.speaker!.isNotEmpty &&
                    (currentView == CalendarView.day ||
                        (currentView == CalendarView.week && tablet)) &&
                    showSpeaker)
                  Text(
                    event.speaker!,
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