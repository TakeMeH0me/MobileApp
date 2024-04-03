import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/presentation/bloc/station/station_bloc.dart';

/// Show one trip to the selected home with single stations,
/// time between the stations and information to each single station.
///
/// The home was selected in [ShowHomesPage].
class ShowWayToHomePage extends StatefulWidget {
  final HomeEntity home;

  const ShowWayToHomePage({
    super.key,
    required this.home,
  });

  @override
  State<ShowWayToHomePage> createState() => _ShowWayToHomePageState();
}

class _ShowWayToHomePageState extends State<ShowWayToHomePage> {
  late final StationEntity _startStation = const StationEntity(
    id: '8010125',
    name: 'Gera Hbf',
  );
  // TODO: später sollte dann die Station im Home mit drinnen sein (also als mainStation oder so)
  late final StationEntity _endStation = const StationEntity(
    id: '8012657',
    name: 'Pößneck ob Bf',
  );

  @override
  void initState() {
    super.initState();
    _initDefaultMeansOfTransport();
  }

  void _initDefaultMeansOfTransport() {
    BlocProvider.of<StationBloc>(context).add(
      GetMeansOfTransportByTime(
        _startStation,
        const TimeOfDay(hour: 13, minute: 40),
      ),
    );
    BlocProvider.of<StationBloc>(context).add(
      GetMeansOfTransportByTime(
        _endStation,
        const TimeOfDay(hour: 14, minute: 40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.home.name,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 10),
                _buildTimeIndicator(),
                const SizedBox(height: 10),
                _buildRouteList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<StationBloc, StationState> _buildTimeIndicator() {
    return BlocBuilder<StationBloc, StationState>(
      builder: (context, state) {
        if (state is StationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StationError) {
          return Text(state.message);
        } else if (state is StationsUpdated) {
          final TimeOfDay time =
              state.meansOfTransportEntities[0].departureTime;
          return Text(
            'Du musst in loslaufen ${time.hour - TimeOfDay.now().hour}h und ${time.minute - TimeOfDay.now().minute}min .${time.toString()}',
            style: const TextStyle(fontSize: 16),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  BlocBuilder<StationBloc, StationState> _buildRouteList() {
    return BlocBuilder<StationBloc, StationState>(
      builder: (context, state) {
        if (state is StationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StationError) {
          return Text(state.message);
        } else if (state is StationsUpdated) {
          return Column(
            children: state.meansOfTransportEntities
                .map(
                  (meansOfTransportEntity) => Column(
                    children: [
                      Text(
                        meansOfTransportEntity.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        '${meansOfTransportEntity.departureTime.hour}:${meansOfTransportEntity.departureTime.minute}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        meansOfTransportEntity.delayInMinutes.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
                .toList(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
