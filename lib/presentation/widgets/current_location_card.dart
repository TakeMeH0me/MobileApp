import 'package:flutter/material.dart';
import 'package:take_me_home/presentation/pages/edit_time_to_start_page.dart';
import 'package:take_me_home/presentation/theme/color_themes.dart';

class CurrentLocationCard extends StatefulWidget {
  final String startStation;
  final String distance;
  final String departureArrival;
  final String track;
  final Icon leadingIcon;
  final Icon trailingIcon;
  final Function(dynamic result) onResult;

  const CurrentLocationCard({
    Key? key,
    required this.startStation,
    required this.distance,
    required this.departureArrival,
    required this.track,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.onResult,
  }) : super(key: key);

  @override
  _CurrentLocationCardState createState() => _CurrentLocationCardState();
}

class _CurrentLocationCardState extends State<CurrentLocationCard> {
  void _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling Navigator.pop on the Selection Screen
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTimeToStart()),
    );

    widget.onResult(result);

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: lightColorScheme.secondary,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        child: ListTile(
          leading: widget.leadingIcon,
          title: Text("${widget.startStation}  ${widget.distance}"),
          subtitle: Text("${widget.departureArrival} \n${widget.track}"),
          trailing: IconButton(
            onPressed: () {
              _navigateAndDisplaySelection(context);
            },
            icon: widget.trailingIcon,
          ),
        ),
      ),
    );
  }
}
