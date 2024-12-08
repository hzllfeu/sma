import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:sma/Utils/AppointmentManager.dart';
import 'package:sma/Utils/PreferencesManager.dart';
import 'package:sma/Utils/StudentModel.dart';
import '../Utils/AppointmentModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AppointmentManager _appointmentManager = AppointmentManager();
  List<AppointmentModel> upcomingAppointments = [];

  @override
  void initState() {
    super.initState();
    _loadUpcomingAppointments();
  }

  Future<void> _loadUpcomingAppointments() async {
    await _appointmentManager.loadAppointments();
    setState(() {
      final now = DateTime.now();
      final threeDaysLater = now.add(const Duration(days: 3));
      upcomingAppointments = _appointmentManager.appointments
          .where((appointment) =>
      appointment.startTime.isAfter(now) &&
          appointment.startTime.isBefore(threeDaysLater))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(MediaQuery.of(context).size.height * 0.14),
                  if (upcomingAppointments.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Aucun cours prévu dans les 3 prochains jours.",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    ..._buildAppointmentCards(),
                ],
              ),
            ),
          ),
          GlassContainer(
            height: MediaQuery.of(context).size.height * 0.12,
            color: const Color(0xFFF3F5F8).withOpacity(0.7),
            blur: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Bienvenue ${StudentModel().surname}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Colors.black.withOpacity(0.8),
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

  List<Widget> _buildAppointmentCards() {
    final now = DateTime.now();
    final groupedAppointments = <String, List<AppointmentModel>>{};

    for (var appointment in upcomingAppointments) {
      final startDate = DateTime(
        appointment.startTime.year,
        appointment.startTime.month,
        appointment.startTime.day,
      );
      final difference = startDate.difference(DateTime(now.year, now.month, now.day)).inDays;

      final group = difference == 0
          ? "Aujourd'hui"
          : difference == 1
          ? "Demain"
          : difference == 2
          ? "Après-demain"
          : "Dans ${difference} jours";

      groupedAppointments.putIfAbsent(group, () => []).add(appointment);
    }

    return groupedAppointments.entries.map((entry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          const Gap(5),
          ...entry.value.map((appointment) => _buildAppointmentCard(appointment)),
          const Gap(20),
        ],
      );
    }).toList();
  }

  Widget _buildAppointmentCard(AppointmentModel appointment) {
    final now = DateTime.now();
    final isOngoing = now.isAfter(appointment.startTime) &&
        now.isBefore(appointment.endTime);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: PreferencesManager().accent.withOpacity(0.2),
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(5),
          right: Radius.circular(7),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 120,
            decoration: BoxDecoration(
              color: PreferencesManager().accent,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(7),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 10, left: 5),
                trailing: Icon(
                  isOngoing ? Icons.play_circle_fill : Icons.access_time,
                  color: isOngoing ? Colors.green : PreferencesManager().secondary,
                ),
                title: Text(
                  appointment.title.isNotEmpty ? appointment.title : "Sans titre",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Salle : ${appointment.location}"),
                    Text("Professeur : ${appointment.speaker}"),
                    Text(
                      "Horaire : ${appointment.startTime.hour}:${appointment.startTime.minute.toString().padLeft(2, '0')} - ${appointment.endTime.hour}:${appointment.endTime.minute.toString().padLeft(2, '0')}",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}