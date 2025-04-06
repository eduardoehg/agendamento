import 'package:flutter/material.dart';
import 'schedule_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> rooms = ['Sala - Day One', 'Sala - Criatividade', 'Sala - Evolução'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Agendamento de Salas - VDV Group ⚡'),
        backgroundColor: const Color.fromARGB(255, 254, 195, 31),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color.fromARGB(255, 254, 195, 31),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  rooms[index],
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScheduleScreen(roomName: rooms[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
