import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

DatabaseReference ref = FirebaseDatabase.instance.ref();

class _HomePageState extends State<HomePage> {
  late SharedPreferences preferences;
  String name1 = "", name2 = "", name3 = "", name4 = '', name5 = "";
  String time1 = "", time2 = "", time3 = "", time4 = '', time5 = "";
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((value) => {
          if (!value)
            {AwesomeNotifications().requestPermissionToSendNotifications()}
        });
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationDisplayedMethod: (receivedNotification) =>
            NotificationController.onNotificationDisplayedMethod(
                receivedNotification),
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod);
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      name1 = preferences.getString('name1') ?? '';
      name2 = preferences.getString('name2') ?? '';
      name3 = preferences.getString('name3') ?? '';
      name4 = preferences.getString('name4') ?? '';
      name5 = preferences.getString('name5') ?? '';
      time1 = preferences.getString('time1').toString();
      time2 = preferences.getString('time2').toString();
      time3 = preferences.getString('time3').toString();
      time4 = preferences.getString('time4').toString();
      time5 = preferences.getString('time5').toString();
      _controller1.text = name1;
      _controller2.text = name2;
      _controller3.text = name3;
      _controller4.text = name4;
      _controller5.text = name5;
      if (time1 != '') {
        final time = time1.split(":");
        setState(() {
          _timeOfDay1 = TimeOfDay(
              hour: int.parse(time[0]),
              minute: int.parse(time[1].substring(0, 2)));
        });
      }
      if (time2 != '') {
        final time = time2.split(":");
        setState(() {
          _timeOfDay2 = TimeOfDay(
              hour: int.parse(time[0]),
              minute: int.parse(time[1].substring(0, 2)));
        });
      }
      if (time3 != '') {
        final time = time3.split(":");
        setState(() {
          _timeOfDay3 = TimeOfDay(
              hour: int.parse(time[0]),
              minute: int.parse(time[1].substring(0, 2)));
        });
      }
      if (time4 != '') {
        final time = time4.split(":");
        setState(() {
          _timeOfDay4 = TimeOfDay(
              hour: int.parse(time[0]),
              minute: int.parse(time[1].substring(0, 2)));
        });
      }
      if (time5 != '') {
        final time = time5.split(":");
        setState(() {
          _timeOfDay5 = TimeOfDay(
              hour: int.parse(time[0]),
              minute: int.parse(time[1].substring(0, 2)));
        });
      }
    });
  }

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();

  TimeOfDay _timeOfDay1 = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _timeOfDay2 = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _timeOfDay3 = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _timeOfDay4 = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _timeOfDay5 = const TimeOfDay(hour: 0, minute: 0);

  void _showtimepicker(String comp) {
    TimeOfDay temp = const TimeOfDay(hour: 0, minute: 0);
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => setState(() {
              switch (comp) {
                case "c1":
                  _timeOfDay1 = value!;
                  break;
                case "c2":
                  _timeOfDay2 = value!;
                  break;
                case "c3":
                  _timeOfDay3 = value!;
                  break;
                case "c4":
                  _timeOfDay4 = value!;
                  break;
                case "c5":
                  _timeOfDay5 = value!;
                  break;
              }
            }));
  }

  void _saveData() async {
    print("daved");
    name1 = _controller1.text;
    name2 = _controller2.text;
    name3 = _controller3.text;
    name4 = _controller4.text;
    name5 = _controller5.text;
    await preferences.setString('name1', name1);
    await preferences.setString('name2', name2);
    await preferences.setString('name3', name3);
    await preferences.setString('name4', name4);
    await preferences.setString('name5', name5);
    await preferences.setString(
        'time1', '$_timeOfDay1.hour:$_timeOfDay1.minute');
    await preferences.setString(
        'time2', '$_timeOfDay2.hour:$_timeOfDay2.minute');
    await preferences.setString(
        'time3', '$_timeOfDay3.hour:$_timeOfDay3.minute');
    await preferences.setString(
        'time4', '$_timeOfDay4.hour:$_timeOfDay4.minute');
    await preferences.setString(
        'time5', '$_timeOfDay5.hour:$_timeOfDay5.minute');
    await preferences.setString(
        'time1', _timeOfDay1.format(context).toString());
    await preferences.setString(
        'time2', _timeOfDay2.format(context).toString());
    await preferences.setString(
        'time3', _timeOfDay3.format(context).toString());
    await preferences.setString(
        'time4', _timeOfDay4.format(context).toString());
    await preferences.setString(
        'time5', _timeOfDay5.format(context).toString());
    await _scheduleNotification("1", name1, _timeOfDay1, 1);
    await _scheduleNotification("2", name2, _timeOfDay2, 2);
    await _scheduleNotification("3", name3, _timeOfDay3, 3);
    await _scheduleNotification("4", name4, _timeOfDay4, 4);
    await _scheduleNotification("5", name5, _timeOfDay5, 5);
    // try {
    //   DatabaseReference ref = FirebaseDatabase.instance.ref("data");
    //   await ref.set({
    //     'comp1': _timeOfDay1.format(context).toString(),
    //     'comp2': _timeOfDay2.format(context).toString(),
    //     'comp3': _timeOfDay3.format(context).toString(),
    //     'comp4': _timeOfDay4.format(context).toString(),
    //     'comp5': _timeOfDay5.format(context).toString(),
    //   });
    //   print('Data sent successfully');
    // } catch (e) {
    //   print('Error sending data: $e');
    // }
  }

  Future<void> _scheduleNotification(
      String compname, String name, TimeOfDay timeOfDay, int id) async {
    print(timeOfDay.minute);

    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: '10',
            title: "Medicine Dispenser",
            body:
                "It's time to take medicine :$name click  on this to show to compartment",
            wakeUpScreen: true,
            autoDismissible: false),
        schedule: NotificationCalendar(hour: timeOfDay.hour, minute: timeOfDay.minute, second: 0, repeats: true, allowWhileIdle: true),
        actionButtons: [NotificationActionButton(key: 'Yes', label: 'Yes')]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red.shade300,
              splashColor: Colors.black,
              tooltip: "Save",
              onPressed: () {},
              child: IconButton.filled(
                onPressed: () {
                  _saveData();
                  const snackbar = SnackBar(
                      showCloseIcon: true,
                      content: Text('Data Saved'),
                      backgroundColor: Color.fromARGB(255, 243, 177, 172),
                      elevation: 10,
                      behavior: SnackBarBehavior.floating);
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                icon: const Icon(Icons.save),
                color: Colors.white,
              ),
            );
          }),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.red[300],
            title: const Text(
              'Medicine Dispenser',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          drawer: Drawer(
            backgroundColor: Colors.red[300],
            child: ListView(children: [
              DrawerHeader(
                  child: ListView(
                children: [
                  Image.asset(
                    'lib/images/medicine.png',
                    width: 100,
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Medicine Dispenser",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lumanosimo(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                iconColor: Colors.white,
                textColor: Colors.white,
                horizontalTitleGap: 10,
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/details');
                },
                leading: const Icon(Icons.details),
                title: const Text("Patient Details"),
                iconColor: Colors.white,
                textColor: Colors.white,
                horizontalTitleGap: 10,
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("About us"),
                iconColor: Colors.white,
                textColor: Colors.white,
                horizontalTitleGap: 10,
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
              )
            ]),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Compartment 1",
                            style: TextStyle(color: Colors.red),
                          ),
                          TextField(
                            controller: _controller1,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(gapPadding: 2),
                                label: Text("Tablet Name"),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10)),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Text(
                                "Time: ${_timeOfDay1.format(context)}",
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  _showtimepicker("c1");
                                },
                                color: Colors.red.shade100,
                                child: const Text("Select Time"),
                              )
                            ],
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Compartment 2",
                            style: TextStyle(color: Colors.red),
                          ),
                          TextField(
                            controller: _controller2,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Tablet Name"),
                                contentPadding: EdgeInsets.all(8)),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Text(
                                "Time: ${_timeOfDay2.format(context)}",
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  _showtimepicker("c2");
                                },
                                color: Colors.red.shade100,
                                child: const Text("Select Time"),
                              )
                            ],
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Compartment 3",
                            style: TextStyle(color: Colors.red),
                          ),
                          TextField(
                            controller: _controller3,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Tablet Name"),
                                contentPadding: EdgeInsets.all(8)),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Text(
                                "Time: ${_timeOfDay3.format(context)}",
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  _showtimepicker("c3");
                                },
                                color: Colors.red.shade100,
                                child: const Text("Select Time"),
                              )
                            ],
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Compartment 4",
                            style: TextStyle(color: Colors.red),
                          ),
                          TextField(
                            controller: _controller4,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Tablet Name"),
                                contentPadding: EdgeInsets.all(8)),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Text(
                                "Time: ${_timeOfDay4.format(context)}",
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  _showtimepicker("c4");
                                },
                                color: Colors.red.shade100,
                                child: const Text("Select Time"),
                              )
                            ],
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Compartment 5",
                            style: TextStyle(color: Colors.red),
                          ),
                          TextField(
                            controller: _controller5,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Tablet Name"),
                                contentPadding: EdgeInsets.all(8)),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Text(
                                "Time: ${_timeOfDay5.format(context)}",
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  _showtimepicker("c5");
                                },
                                color: Colors.red.shade100,
                                child: const Text("Select Time"),
                              )
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
          )),
    );
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    print("Notification created");
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    print("notification disp");
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    print("dismiss");
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    // print("action");
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("data");
      await ref.set({'comp': receivedAction.id.toString()});
      print('Data sent successfully');
    } catch (e) {
      print('Error sending data: $e');
    }
    // Navigate into pages, avoiding to open the notification details page over another details page already opened
  }
}
