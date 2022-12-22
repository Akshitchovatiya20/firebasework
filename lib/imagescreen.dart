import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  FlutterLocalNotificationsPlugin? localll;

  TextEditingController txtid = TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtmob = TextEditingController();
  TextEditingController txtstd = TextEditingController();
  List<DataModel> datalist = [];

  @override
  void initState() {
    super.initState();
    notifications();
    firenotification();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  var image = ByteArrayAndroidBitmap(await getimage("https://cars.tatamotors.com/images/performance-new.jpg"));
                  BigPictureStyleInformation big =
                      BigPictureStyleInformation(image);
                  AndroidNotificationDetails and = AndroidNotificationDetails(
                      "1", "Android",
                      priority: Priority.high,
                      importance: Importance.max,
                      sound: RawResourceAndroidNotificationSound('sound'),
                      styleInformation: big);
                  NotificationDetails nd = NotificationDetails(android: and);
                  await localll!.show(1, "Hello", "Tamare Massge Aavyo 6", nd);
                },
                child: Text("Notification"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  AndroidNotificationDetails and = AndroidNotificationDetails(
                      "1", "Android",
                      priority: Priority.high, importance: Importance.max);
                  NotificationDetails nd = NotificationDetails(android: and);
                  await localll!.zonedSchedule(1, "Hello", "body",
                      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)), nd,
                      uiLocalNotificationDateInterpretation:
                          UILocalNotificationDateInterpretation.absoluteTime,
                      androidAllowWhileIdle: true);
                },
                child: Text("NotificationTime"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void notifications() async {
    localll = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings android =
        AndroidInitializationSettings('car');
    DarwinInitializationSettings ios = DarwinInitializationSettings();
    InitializationSettings flutter =
        InitializationSettings(android: android, iOS: ios);
    tz.initializeTimeZones();
    await localll!.initialize(flutter);
  }

  Future<Uint8List> getimage(String uri)async{
    var imagstring =await http.get(Uri.parse(uri));
    return imagstring.bodyBytes;
  }

  void firenotification()
  async{
    FirebaseMessaging msg = FirebaseMessaging.instance;
    var idtoken = await msg.getToken();
    print("Token is ======= $idtoken");

      // FirebaseMessaging.onBackgroundMessage((message) {
    //
    // },);

    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      print("message recieved");
      print(msg.notification!.body);
      var data = msg.notification!.body;
      var title = msg.notification!.title;

      //notificationData();
      print("=================Title : $title \n Body : $data");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }
}

class DataModel {
  String? id, name, mob, std, key;

  DataModel({this.id, this.name, this.mob, this.std, this.key});
}
