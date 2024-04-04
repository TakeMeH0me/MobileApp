import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditTimeToStart extends StatefulWidget {
  const EditTimeToStart({super.key});

  @override
  State<EditTimeToStart> createState() => _EditTimeToStartState();
}

class _EditTimeToStartState extends State<EditTimeToStart> {
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
              _buildHourTextField(),
              _buildMinuteTextField(),
              _buildSaveButton(context)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();

    super.dispose();
  }

  TextField _buildHourTextField() {
    return TextField(
      controller: hourController,
      decoration: const InputDecoration(labelText: 'Stunde'),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  TextField _buildMinuteTextField() {
    return TextField(
      controller: minuteController,
      decoration: const InputDecoration(labelText: 'Minute'),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  ElevatedButton _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      child: const Icon(Icons.save),
      onPressed: () {
        final int hour = int.tryParse(hourController.text) ?? 0;
        final int minute = int.tryParse(minuteController.text) ?? 0;

        TimeOfDay selectedTime = TimeOfDay(hour: hour, minute: minute);

        Navigator.pop(context, selectedTime);
      },
    );
  }
}
