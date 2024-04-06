import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/presentation/bloc/station/station_bloc.dart';
import 'package:take_me_home/presentation/helper/time_transformer.dart';
import 'package:take_me_home/presentation/widgets/edit_means_of_transport_card.dart';
import 'package:take_me_home/presentation/widgets/means_of_transport_card.dart';

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
  final MeansOfTransportEntity startMeansOfTransport =
      MeansOfTransportEntity.empty().copyWith(name: 'Zum Bahnhof');
  final MeansOfTransportEntity endMeansOfTransport =
      MeansOfTransportEntity.empty().copyWith(name: 'Nach Hause');

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
        startTime: TimeOfDay.now(),
        endTime: TimeTransformer.addTime(
          TimeOfDay.now(),
          const Duration(hours: 0, minutes: 50),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () async {
              _initDefaultMeansOfTransport();
            },
            child: ListView(
              children: [
                Text(
                  widget.home.name,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 10.0),
                _buildTimeIndicator(),
                const SizedBox(height: 10.0),
                Expanded(child: _buildRouteList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<StationBloc, StationState> _buildTimeIndicator() {
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
          return _buildDiffTimeText();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Text _buildDiffTimeText() {
    final TimeOfDay diffTimeToStartGoingHome = TimeTransformer.diffTime(
      TimeOfDay.now(),
      Duration(
        hours: startMeansOfTransport.departureTime.hour,
        minutes: startMeansOfTransport.departureTime.minute,
      ),
    );

    return Text(
      'Du musst in ${diffTimeToStartGoingHome.hour}h und ${diffTimeToStartGoingHome.minute}min loslaufen!',
      style: const TextStyle(fontSize: 16),
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

          return Column(
            children: [
              EditMeansOfTransportCard(
                  meansOfTransport: startMeansOfTransport,
                  onEdit: (meansOfTransportEntity) {}),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stations.length,
                itemBuilder: (context, index) {
                  return MeansOfTransportCard(
                    station: stations[index],
                    meansOfTransport: meansOfTransportEntities[index],
                  );
                },
              ),
              EditMeansOfTransportCard(
                  meansOfTransport: endMeansOfTransport,
                  onEdit: (meansOfTransportEntity) {}),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
