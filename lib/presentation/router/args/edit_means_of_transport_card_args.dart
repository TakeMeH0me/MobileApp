import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';

class EditMeansOfTransportCardArgs {
  final MeansOfTransportEntity meansOfTransport;
  final Duration duration;

  EditMeansOfTransportCardArgs({
    required this.meansOfTransport,
    required this.duration,
  });
}
