import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/presentation/helper/icon_transformer.dart';
import 'package:take_me_home/presentation/router/args/edit_means_of_transport_card_args.dart';
import 'package:take_me_home/presentation/widgets/edit_card.dart';

class EditMeansOfTransportCardPage extends StatefulWidget {
  final MeansOfTransportEntity meansOfTransport;
  final Duration duration;

  const EditMeansOfTransportCardPage({
    super.key,
    required this.meansOfTransport,
    required this.duration,
  });

  @override
  State<EditMeansOfTransportCardPage> createState() =>
      _EditMeansOfTransportCardPageState();
}

class _EditMeansOfTransportCardPageState
    extends State<EditMeansOfTransportCardPage> {
  late MeansOfTransportEntity currentMeansOfTransport = widget.meansOfTransport;
  late Duration currentDuration = widget.duration;

  late final TextEditingController _nameController = TextEditingController(
    text: widget.meansOfTransport.name,
  );
  late final TextEditingController _minutesDurationController =
      TextEditingController(
    text: widget.duration.inMinutes.toString(),
  );

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_onNameChanged);
    _minutesDurationController.addListener(_onMinutesDurationChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeading(),
              const SizedBox(height: 10.0),
              _buildTypeSelectorEditCard(),
              const SizedBox(height: 10.0),
              _buildNameEditCard(),
              const SizedBox(height: 10.0),
              _buildDurationInMinutesEditCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _minutesDurationController.dispose();

    super.dispose();
  }

  Text _buildHeading() {
    return Text(
      widget.meansOfTransport.name,
      style: const TextStyle(fontSize: 25.0),
    );
  }

  EditCard _buildTypeSelectorEditCard() {
    return EditCard(
      leadingIcon: Icon(
        MeansOfTransportTransportTransformer.getTypeAsIconData(
            currentMeansOfTransport.type),
      ),
      mainContent: _buildTypeSelection(),
    );
  }

  DropdownButton<MeansOfTransportType> _buildTypeSelection() {
    return DropdownButton(
      items: MeansOfTransportType.values
          .map(
            (type) => DropdownMenuItem(
              value: type,
              child: Text(
                  MeansOfTransportTransportTransformer.getTypeAsString(type)),
            ),
          )
          .toList(),
      value: currentMeansOfTransport.type,
      onChanged: (value) {
        setState(() {
          currentMeansOfTransport = currentMeansOfTransport.copyWith(
            type: value,
          );
        });
      },
    );
  }

  EditCard _buildNameEditCard() {
    return EditCard(
      mainContent: TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          labelText: 'Name',
        ),
      ),
    );
  }

  EditCard _buildDurationInMinutesEditCard() {
    return EditCard(
      mainContent: TextField(
        controller: _minutesDurationController,
        decoration: const InputDecoration(
          labelText: 'Duration (minutes)',
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(EditMeansOfTransportCardArgs(
            meansOfTransport: currentMeansOfTransport,
            duration: currentDuration,
          ));
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  void _onNameChanged() {
    setState(() {
      currentMeansOfTransport = currentMeansOfTransport.copyWith(
        name: _nameController.text,
      );
    });
  }

  void _onMinutesDurationChanged() {
    setState(() {
      if (_minutesDurationController.text.isEmpty) {
        return;
      }

      currentDuration = Duration(
        minutes: int.parse(_minutesDurationController.text),
      );
    });
  }
}
