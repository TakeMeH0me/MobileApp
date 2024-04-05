import 'package:flutter/material.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/presentation/theme/color_themes.dart';

class StopoverCard extends StatefulWidget {
  final StationEntity station;
  final MeansOfTransportEntity meansOfTransport;

  const StopoverCard({
    super.key,
    required this.station,
    required this.meansOfTransport,
  });

  @override
  State<StopoverCard> createState() => _StopoverCardState();
}

class _StopoverCardState extends State<StopoverCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.meansOfTransport.isDelayed
          ? Theme.of(context).colorScheme.error
          : lightColorTheme.colorScheme.surface,
      child: ListTile(
        leading: _getLeadingIconByMeansOfTransportType(),
        trailing: widget.meansOfTransport.isDelayed
            ? const Icon(Icons.warning)
            : null,
        title:
            Text('${widget.meansOfTransport.name} von ${widget.station.name}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.meansOfTransport.isDelayed
                ? Text(
                    'Verspätung: ${widget.meansOfTransport.delayInMinutes} min')
                : const SizedBox.shrink(),
            widget.meansOfTransport.isDelayed
                ? Text(
                    'Abfahrt: ${widget.meansOfTransport.departureTime.format(context)} -> ${_addTime(widget.meansOfTransport.departureTime, Duration(minutes: widget.meansOfTransport.delayInMinutes)).format(context)}')
                : Text(
                    'Abfahrt: ${widget.meansOfTransport.departureTime.format(context)}'),
          ],
        ),
      ),
    );
  }

  Icon _getLeadingIconByMeansOfTransportType() {
    switch (widget.meansOfTransport.type) {
      case MeansOfTransportType.bus:
        return const Icon(Icons.directions_bus);
      case MeansOfTransportType.train:
        return const Icon(Icons.train);
      case MeansOfTransportType.tram:
        return const Icon(Icons.tram);
      case MeansOfTransportType.unknown:
        return const Icon(Icons.question_mark);
    }
  }

  TimeOfDay _addTime(TimeOfDay timeOfDay, Duration duration) {
    final newDateTime =
        DateTime(0, 0, 0, timeOfDay.hour, timeOfDay.minute).add(duration);
    return TimeOfDay(hour: newDateTime.hour, minute: newDateTime.minute);
  }
}
