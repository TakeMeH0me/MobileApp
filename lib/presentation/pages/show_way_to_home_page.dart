import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/presentation/bloc/station/station_bloc.dart';
import 'package:take_me_home/presentation/widgets/stopover_card.dart';

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
  @override
  void initState() {
    super.initState();
    _initDefaultMeansOfTransport();
  }

  void _initDefaultMeansOfTransport() {
    BlocProvider.of<StationBloc>(context).add(
      GetMeansOfTransportByTime(
        startStation: const StationEntity(
          id: '8010125',
          name: 'Gera Hbf',
        ),
        endStation: widget.home.mainStation,
        startTime: const TimeOfDay(hour: 17, minute: 40),
        endTime: const TimeOfDay(hour: 18, minute: 40),
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
                const SizedBox(height: 10.0),
                _buildTimeIndicator(),
                const SizedBox(height: 10.0),
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
            'Du musst in  ${time.hour - TimeOfDay.now().hour}h und ${time.minute - TimeOfDay.now().minute}min .${time.toString()} loslaufen!',
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
      buildWhen: (previous, current) =>
          current is StationInitial ||
          current is StationsUpdated ||
          current is StationError,
      builder: (context, state) {
        if (state is StationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StationError) {
          return Text(state.message);
        } else if (state is StationsUpdated) {
          final List<StationEntity> stations = state.stations;
          final List<MeansOfTransportEntity> meansOfTransportEntities =
              state.meansOfTransportEntities;

          if (stations.isEmpty || meansOfTransportEntities.isEmpty) {
            return const SizedBox.shrink();
          }

          if (stations.length != meansOfTransportEntities.length) {
            return const Text('Error while loading stations: Length mismatch.');
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stations.length,
            itemBuilder: (context, index) {
              return StopoverCard(
                station: stations[index],
                meansOfTransport: meansOfTransportEntities[index],
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
