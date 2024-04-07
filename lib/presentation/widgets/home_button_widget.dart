import 'package:flutter/material.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';

/// Button for interacting with a home. E. g. edit it's properties
/// or show all stopvers.
class HomeButton extends StatefulWidget {
  final Function() onPressed;
  final Function() onTrailingPressed;
  final HomeEntity home;

  const HomeButton({
    super.key,
    required this.onPressed,
    required this.onTrailingPressed,
    required this.home,
  });

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {widget.onPressed()},
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: ListTile(
        leading: const Icon(Icons.home),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => {widget.onTrailingPressed()},
        ),
        contentPadding: const EdgeInsets.all(0.0),
        title: Text(widget.home.name),
        subtitle: Text(widget.home.city),
      ),
    );
  }
}
