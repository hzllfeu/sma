import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sma/Screens/Settings.dart';
import 'package:sma/Utils/PopupMessage.dart';
import 'package:sma/Utils/PreferencesManager.dart';

import 'Calendar.dart';


class Navigator extends StatefulWidget {
  final int initialIndex;

  const Navigator({Key? key, this.initialIndex = 0}) : super(key: key);


  @override
  State<Navigator> createState() => _NavigatorState();
}

class _NavigatorState extends State<Navigator> {
  late int currentSelectedIndex;


  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
    PopupManager().showmessage(text: "Page switched");
  }


  @override
  void initState() {
    super.initState();
    currentSelectedIndex = widget.initialIndex;
  }


  List<Widget> pages = [
    const Center(
      child: Text("Home"),
    ),
    Calendar(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xFFF3F5F8),
        bottomNavigationBar:CupertinoTabBar(
          onTap: updateCurrentIndex,
          currentIndex: currentSelectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedHome09,
                color: Colors.black.withOpacity(0.6),
                size: 18,
              ),
              activeIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedHome09,
                color: PreferencesManager().accent,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(
              icon: HugeIcon(
              icon: HugeIcons.strokeRoundedCalendar03,
               color: Colors.black.withOpacity(0.6),
              size: 18,
            ),
              activeIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedCalendar03,
                color: PreferencesManager().accent,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedAccountSetting03,
                color: Colors.black.withOpacity(0.6),
                size: 18,
              ),
              activeIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedAccountSetting03,
                color: PreferencesManager().accent,
                size: 20,
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            pages[currentSelectedIndex],
          ],
        )
    );
  }
}
