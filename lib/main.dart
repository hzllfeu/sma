import 'package:flutter/material.dart';
import 'package:sma/Utils/PopupMessage.dart';
import 'package:sma/Utils/PreferencesManager.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:sma/Screens/Navigator.dart' as sma;


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('fr', CustomFrenchMessages());
  PreferencesManager().loadPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: PopupManager().navigatorKey,
        debugShowCheckedModeBanner: false,
        home: sma.Navigator()
    );
  }
}



class CustomFrenchMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'dans';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'maintenant';
  @override
  String aboutAMinute(int minutes) => 'une minute';
  @override
  String minutes(int minutes) => '$minutes minutes';
  @override
  String aboutAnHour(int minutes) => 'une heure';
  @override
  String hours(int hours) => '$hours heures';
  @override
  String aDay(int hours) => 'un jour';
  @override
  String days(int days) => '$days jours';
  @override
  String aboutAMonth(int days) => 'un mois';
  @override
  String months(int months) => '$months mois';
  @override
  String aboutAYear(int year) => 'un an';
  @override
  String years(int years) => '$years ans';
  @override
  String wordSeparator() => '';
}
