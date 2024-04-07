import 'package:take_me_home/domain/entities/home_entity.dart';

/// This class provides the arguments for the [CreateOrEditHomePage].
///
/// The [home] is the home, the way is shown to.
class ShowWayToHomeArgs {
  final HomeEntity home;

  const ShowWayToHomeArgs({
    required this.home,
  });
}
