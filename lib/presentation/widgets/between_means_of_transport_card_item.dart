import 'package:flutter/material.dart';

class BetweenMeansOfTransportCardItem extends StatefulWidget {
  final Duration duration;

  const BetweenMeansOfTransportCardItem({
    super.key,
    required this.duration,
  });

  @override
  State<BetweenMeansOfTransportCardItem> createState() =>
      _BetweenMeansOfTransportCardItemState();
}

class _BetweenMeansOfTransportCardItemState
    extends State<BetweenMeansOfTransportCardItem> {
  final double listWidth = 5.0;
  final int dashedLinesCount = 4;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: listWidth,
          child: _buildDashedLinesList(),
        ),
        const SizedBox(width: 10.0),
        _buildDurationText(),
      ],
    );
  }

  ListView _buildDashedLinesList() {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) => _buildDashedLine(),
      separatorBuilder: (context, index) => const SizedBox(height: 5.0),
      itemCount: dashedLinesCount,
    );
  }

  Widget _buildDashedLine() {
    return Container(
      height: 15.0,
      width: listWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(1.0),
      ),
    );
  }

  Text _buildDurationText() {
    return Text(
      '${widget.duration.inHours}h ${widget.duration.inMinutes.remainder(60)}m',
    );
  }
}
