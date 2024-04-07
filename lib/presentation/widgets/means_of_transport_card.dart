import 'package:flutter/material.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/presentation/helper/icon_transformer.dart';
import 'package:take_me_home/presentation/helper/time_transformer.dart';

class MeansOfTransportCard extends StatefulWidget {
  final StationEntity station;
  final MeansOfTransportEntity meansOfTransport;

  const MeansOfTransportCard({
    super.key,
    required this.station,
    required this.meansOfTransport,
  });

  @override
  State<MeansOfTransportCard> createState() => _MeansOfTransportCardState();
}

class _MeansOfTransportCardState extends State<MeansOfTransportCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.meansOfTransport.isDelayed
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.surface,
      child: ListTile(
        leading: Icon(MeansOfTransportTransportTransformer.getTypeAsIconData(
          widget.meansOfTransport.type,
        )),
        trailing: widget.meansOfTransport.isDelayed
            ? const Icon(Icons.warning)
            : null,
        title:
            Text('${widget.meansOfTransport.name} von ${widget.station.name}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.meansOfTransport.isDelayed
                ? _buildDelayText()
                : const SizedBox.shrink(),
            widget.meansOfTransport.isDelayed
                ? _buildDelayedDepartureTimeText()
                : _buildDepartureTimeText(),
          ],
        ),
      ),
    );
  }

  Text _buildDelayText() {
    return Text('Verspätung: ${widget.meansOfTransport.delayInMinutes} min');
  }

  Text _buildDelayedDepartureTimeText() {
    final TimeOfDay delayedDepartureTime = TimeTransformer.addTime(
        widget.meansOfTransport.departureTime,
        Duration(minutes: widget.meansOfTransport.delayInMinutes));

    return Text(
        'Abfahrt: ${TimeTransformer.toIso8601WithoutSeconds(widget.meansOfTransport.departureTime)} -> ${TimeTransformer.toIso8601WithoutSeconds(delayedDepartureTime)}');
  }

  Text _buildDepartureTimeText() {
    return Text(
        'Abfahrt: ${TimeTransformer.toIso8601WithoutSeconds(widget.meansOfTransport.departureTime)}');
  }
}
