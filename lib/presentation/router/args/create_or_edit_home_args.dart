import 'package:take_me_home/domain/entities/home_entity.dart';

/// This class provides the arguments for the [CreateOrEditHomePage].
///
/// The [home] is the home, which is currently edited / created.
/// The [isNewHome] is a boolean, which indicates, if the home is created or edited.
class CreateOrEditHomeArgs {
  final HomeEntity home;
  final bool isNewHome;

  CreateOrEditHomeArgs({
    required this.home,
    required this.isNewHome,
  });
}
