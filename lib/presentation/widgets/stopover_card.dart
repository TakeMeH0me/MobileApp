import 'package:flutter/material.dart';

class StopoverCard extends StatefulWidget {
  final String startStation;
  final String distance;
  final String departureArrival;
  final String track;
  final Icon leadingIcon;
  final Icon? trailingIcon;

  const StopoverCard({
    Key? key,
    required this.startStation,
    required this.distance,
    required this.departureArrival,
    required this.track,
    required this.leadingIcon,
    this.trailingIcon,
  }) : super(key: key);

  @override
  State<StopoverCard> createState() => _StopoverCardState();
}

class _StopoverCardState extends State<StopoverCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: widget.leadingIcon,
        title: Text('${widget.startStation}  ${widget.distance}'),
        subtitle: Text('${widget.departureArrival} \n${widget.track}'),
        trailing: widget.trailingIcon,
      ),
    );
  }
}
