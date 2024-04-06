import 'package:flutter/material.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';

class EditMeansOfTransportCardPage extends StatefulWidget {
  final MeansOfTransportEntity meansOfTransport;

  const EditMeansOfTransportCardPage({
    super.key,
    required this.meansOfTransport,
  });

  @override
  State<EditMeansOfTransportCardPage> createState() =>
      _EditMeansOfTransportCardPageState();
}

class _EditMeansOfTransportCardPageState
    extends State<EditMeansOfTransportCardPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
