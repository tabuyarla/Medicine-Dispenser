import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicinedispenser/Details.dart';
import 'package:medicinedispenser/aboutus.dart';
import 'package:medicinedispenser/firebase_options.dart';
import 'package:medicinedispenser/home.dart';
import 'package:medicinedispenser/intro.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: '10',
          channelName: "Notification",
          channelDescription: 'Medicine Dispenser',
          channelGroupKey: 'basic_grp',
          defaultColor: Colors.red.shade100,
          playSound: true,
          importance: NotificationImportance.High,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => const HomePage(),
        '/details': (context) => const Details(),
        '/about': (context) => const AboutUs()
      },
      home: const IntroPage(),
    );
  }
}
