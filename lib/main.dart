import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'notificationservice.dart';



void main() {

// to ensure all the widgets are initialized.
  WidgetsFlutterBinding.ensureInitialized();

// to initialize the notificationservice.
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule Local notification',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Schedule Local notification'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController notificationTitleController = TextEditingController();
  TextEditingController notificationDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Check Notification", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 20),
                TextField(
                  controller: notificationTitleController,
                  decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Enter Title", prefixIcon: Icon(Icons.title),),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: notificationDescriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Description",
                    prefixIcon: Icon(Icons.description),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    NotificationService().showNotification(
                      10,
                      notificationTitleController.text,
                      notificationDescriptionController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                  ),
                  child: Text("Show Notification", style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
