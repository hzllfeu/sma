import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sma/Utils/PopupMessage.dart';
import 'package:sma/Utils/PreferencesManager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});


  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xFFFFFAFA),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(MediaQuery.of(context).size.height*0.14),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: PreferencesManager().accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Votre compte",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                ),
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedUserEdit01,
                                  color: Colors.black.withOpacity(0.8),
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14
                              ),
                            ),
                          ),
                          const Gap(5),
                          Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: PreferencesManager().accent.withOpacity(0.15),
                            ),
                            child: Row(
                              children: [
                                const Gap(15),
                                Text(
                                  "louis.mouchon@edu.devinci.fr",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(10),
                          Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: PreferencesManager().secondary.withOpacity(0.4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Se déconnecter",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15
                                  ),
                                ),
                                const Gap(10),
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedLogoutSquare01,
                                  color: Colors.black.withOpacity(0.9),
                                  size: 18,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Gap(20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: PreferencesManager().accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Préférences",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                ),
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedSettings05,
                                  color: Colors.black.withOpacity(0.8),
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          const Gap(150),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: PreferencesManager().accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Notifications",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                ),
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedNotification02,
                                  color: Colors.black.withOpacity(0.8),
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          const Gap(150),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            GlassContainer(
              height: MediaQuery.of(context).size.height*0.12,
              color: const Color(0xFFF3F5F8).withOpacity(0.7),
              blur: 10,
              child: Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05, bottom: 10, left: MediaQuery.of(context).size.width*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 15,),
                        Text(
                          "Options",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Colors.black.withOpacity(0.8)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
