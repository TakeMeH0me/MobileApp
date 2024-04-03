import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditTimeToStart extends StatefulWidget {
  const EditTimeToStart({super.key});

  @override
  State<EditTimeToStart> createState() => _EditTimeToStartState();
}

class _EditTimeToStartState extends State<EditTimeToStart> {
  // Zwei Controller für Stunden und Minuten
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              // Textfeld für Stunden
              TextField(
                controller: hourController,
                decoration: const InputDecoration(labelText: 'Stunde'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              // Textfeld für Minuten
              TextField(
                controller: minuteController,
                decoration: const InputDecoration(labelText: 'Minute'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              ElevatedButton(
                child: const Icon(Icons.save),
                onPressed: () {
                  // Erstellung eines TimeOfDay Objektes aus den Eingaben
                  final int hour = int.tryParse(hourController.text) ??
                      0; // Standardwert 0, wenn Konvertierung fehlschlägt
                  final int minute = int.tryParse(minuteController.text) ??
                      0; // Standardwert 0, wenn Konvertierung fehlschlägt

                  TimeOfDay selectedTime =
                      TimeOfDay(hour: hour, minute: minute);

                  // Verwendung von Navigator.pop, um die ausgewählte Zeit zurück zur vorherigen Seite zu senden
                  Navigator.pop(context, selectedTime);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Controller entsorgen, wenn das Widget entfernt wird
    hourController.dispose();
    minuteController.dispose();
    super.dispose();
  }
}
