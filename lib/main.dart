
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MeetingRoomApp());
}

class MeetingRoomApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agendamento de Salas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
