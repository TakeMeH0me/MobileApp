import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';

/// Arguments for the [EditMeansOfTransportCard] widget.
///
/// Contains the [MeansOfTransportEntity] to edit.
/// Contains the [Duration] to edit. Based on this duration the departure time
/// for the means of transport is calculated.
class EditMeansOfTransportCardArgs {
  final MeansOfTransportEntity meansOfTransport;
  final Duration duration;

  EditMeansOfTransportCardArgs({
    required this.meansOfTransport,
    required this.duration,
  });
}
