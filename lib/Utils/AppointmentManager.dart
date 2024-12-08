import 'package:http/http.dart' as http;
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:sma/Utils/StudentModel.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../Screens/Calendar.dart';
import 'AppointmentModel.dart';
import 'package:sma/Utils/PreferencesManager.dart';

import 'DatabaseManager.dart';
import 'PopupMessage.dart';

class AppointmentManager {
  static final AppointmentManager _instance = AppointmentManager._internal();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<AppointmentModel> appointments = [];
  bool isLoading = true;

  AppointmentManager._internal();

  factory AppointmentManager() => _instance;

  Future<void> loadAppointments() async {
    // Charger depuis la base de données locale
    final dbAppointments = await _dbHelper.getAppointments();
    appointments = dbAppointments;
    isLoading = false;
    // Récupérer les nouveaux rendez-vous depuis l'API
    await fetchSchedule();
  }

  Future<void> fetchSchedule() async {
    try {
      final response = await http.get(Uri.https('ical.devinci.me', 'ical_student/${StudentModel().APIToken}'));

      if (response.statusCode == 200) {
        final calendar = ICalendar.fromString(response.body);
        final List<Map<String, dynamic>> data = calendar.data;
        data.removeWhere((item) => item['type'] != "VEVENT");

        final List<AppointmentModel> newAppointments = data.map((event) {
          final start = (event['dtstart'] as IcsDateTime).toDateTime();
          final end = (event['dtend'] as IcsDateTime).toDateTime();
          final location = event['location'] as String? ?? 'Unknown';
          final subject = event['summary']?.toString() ?? 'No Subject';

          final summary = event['summary']?.toString() ?? '';

          final titleMatch = RegExp(r'\[.*?\](.*?)\[').firstMatch(summary);
          final title = titleMatch?.group(1)?.trim() ?? ''; // Texte après les premiers crochets

          final speakerMatch = RegExp(r'\[.*?\].*?\[.*?\](.*)').firstMatch(summary);
          final speaker = speakerMatch?.group(1)?.trim() ?? ''; // Texte après les deuxièmes crochets

          final groupClass = event['groupClass']?.toString() ?? 'No Subject';

          return AppointmentModel(
            startTime: start!,
            endTime: end!,
            location: location,
            subject: subject,
            title: title,
            speaker: speaker,
            groupClass: groupClass,
          );
        }).toList();

        // Mettre à jour la base de données
        await _dbHelper.clearAppointments();
        for (final appointment in newAppointments) {
          await _dbHelper.insertAppointment(appointment);
        }

        appointments = newAppointments;
      } else {
        PopupManager().showmessage(text: "Erreur API");
      }
    } catch (error) {
      PopupManager().showmessage(text: "Pas de connexion");
      print(error);
    }
  }

  AppointmentDataSource getDataSource() {
    return AppointmentDataSource(
      appointments.map((appointment) {
        return Appointment(
          startTime: appointment.startTime,
          endTime: appointment.endTime,
          subject: appointment.subject,
          color: PreferencesManager().accent.withOpacity(0.4),
        );
      }).toList(),
      appointments,
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  final List<AppointmentModel> appointmentModels;

  AppointmentDataSource(List<Appointment> appointments, this.appointmentModels) {
    this.appointments = appointments;
  }

  AppointmentModel getAppointmentModel(Appointment appointment) {
    final index = appointments!.indexOf(appointment);
    return appointmentModels[index];
  }
}
