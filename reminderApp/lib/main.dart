import 'package:flutter/material.dart';
import 'package:reminderApp/list/List.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reminder App',
      theme: ThemeData(
        // primarySwatch: Colors.indigo[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ReminderList(),
    );
  }
}
