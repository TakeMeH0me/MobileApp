import 'package:flutter/material.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/presentation/helper/icon_transformer.dart';
import 'package:take_me_home/presentation/helper/time_transformer.dart';
import 'package:take_me_home/presentation/theme/color_themes.dart';

class EditMeansOfTransportCard extends StatefulWidget {
  final MeansOfTransportEntity meansOfTransport;
  final Function(MeansOfTransportEntity) onEdit;

  const EditMeansOfTransportCard({
    super.key,
    required this.meansOfTransport,
    required this.onEdit,
  });

  @override
  State<EditMeansOfTransportCard> createState() =>
      _EditMeansOfTransportCardState();
}

class _EditMeansOfTransportCardState extends State<EditMeansOfTransportCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: lightColorTheme.colorScheme.surface,
      child: ListTile(
        leading: Icon(IconTransformer.fromMeansOfTransportType(
          widget.meansOfTransport.type,
        )),
        trailing: IconButton(
          onPressed: () => widget.onEdit(widget.meansOfTransport),
          icon: const Icon(Icons.edit),
        ),
        title: Text(widget.meansOfTransport.name),
        subtitle: _buildDepartureTimeText(),
      ),
    );
  }

  Text _buildDepartureTimeText() {
    return Text(
        'Abfahrt: ${TimeTransformer.toIso8601WithoutSeconds(widget.meansOfTransport.departureTime)}');
  }
}
