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
                        color: Colors.transparent,
                        border: Border.all(
                          color: PreferencesManager().accent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedUserEdit01,
                                color: Colors.black.withOpacity(0.8),
                                size: 18,
                              ),
                              const Gap(15),
                              Text(
                                "Votre compte",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16
                                ),
                              ),
                            ],
                          ),
                          const Gap(15),
                          Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 14
                            ),
                          ),
                          const Gap(5),
                          Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.black.withOpacity(0.3),
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
                        color: Colors.transparent,
                        border: Border.all(
                          color: PreferencesManager().accent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedNotification02,
                                color: Colors.black.withOpacity(0.8),
                                size: 18,
                              ),
                              const Gap(15),
                              Text(
                                "Notifications",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16
                                ),
                              ),
                            ],
                          ),
                          const Gap(200),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: PreferencesManager().accent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedConfiguration01,
                                color: Colors.black.withOpacity(0.8),
                                size: 18,
                              ),
                              const Gap(15),
                              Text(
                                "Personalisation",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16
                                ),
                              ),
                            ],
                          ),
                          const Gap(200),
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
