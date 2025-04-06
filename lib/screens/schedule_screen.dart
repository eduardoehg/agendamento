import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  final String roomName;

  ScheduleScreen({required this.roomName});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime? selectedDateTime;
  List<DateTime> agendamentos = [];

  void _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _scheduleRoom() {
    if (selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecione data e hora.')),
      );
      return;
    }

    setState(() {
      agendamentos.add(selectedDateTime!);
      selectedDateTime = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sala agendada com sucesso!')),
    );
  }

  void _showAgendamentos() {
    if (agendamentos.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Agendamentos"),
          content: Text("Nenhuma sala foi agendada ainda."),
          actions: [
            TextButton(
              child: Text("Fechar"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    String lista = agendamentos.map((dt) {
      return "${dt.day}/${dt.month}/${dt.year} às ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    }).join("\n");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Agendamentos para ${widget.roomName}"),
        content: Text(lista),
        actions: [
          TextButton(
            child: Text("Fechar"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Agendar ${widget.roomName}'),
        backgroundColor: Color.fromARGB(255, 254, 195, 31),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _pickDateTime,
              icon: Icon(Icons.calendar_today),
              label: Text('Selecionar Data e Hora'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 254, 195, 31),
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 16),
            if (selectedDateTime != null)
              Text(
                'Selecionado: ${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year} às ${selectedDateTime!.hour.toString().padLeft(2, '0')}:${selectedDateTime!.minute.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 16, foreground: Paint()..color = Color.fromARGB(255, 254, 195, 31)),
              ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _scheduleRoom,
              child: Text('Agendar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 254, 195, 31),
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showAgendamentos,
              child: Text('Ver Agendamentos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 254, 195, 31),
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
