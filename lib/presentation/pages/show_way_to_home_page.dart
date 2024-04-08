import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget/home_widget.dart';
import 'package:take_me_home/core/widget_adapter.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/main.dart';
import 'package:take_me_home/presentation/bloc/station/station_bloc.dart';
import 'package:take_me_home/presentation/helper/time_transformer.dart';
import 'package:take_me_home/presentation/router/app_router.dart';
import 'package:take_me_home/presentation/router/args/edit_means_of_transport_card_args.dart';
import 'package:take_me_home/presentation/widgets/between_means_of_transport_card_item.dart';
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
  MeansOfTransportEntity startMeansOfTransport =
      MeansOfTransportEntity.empty().copyWith(name: 'Zum Bahnhof');
  MeansOfTransportEntity endMeansOfTransport =
      MeansOfTransportEntity.empty().copyWith(name: 'Nach Hause');

  Duration startDuration = const Duration();
  Duration endDuration = const Duration();

  @override
  void initState() {
    super.initState();
    _initDefaultMeansOfTransport();
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
                _buildHeading(),
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
          const Duration(hours: 0, minutes: 40),
        ),
      ),
    );
  }

  void updateRouteInformation(List<MeansOfTransportEntity>? mot) {
    if (!Platform.isIOS) {
      return;
    }

    HomeWidget.setAppGroupId(MainApp.appGroupId);
    HomeWidget.saveWidgetData<String>(
      'routeinformation_json',
      mot == null
          ? null
          : RouteInformationAdapter.toRouteInformation(mot).toJson().toString(),
    );

    HomeWidget.updateWidget(
      iOSName: 'takeMeHomeWidget',
    );
  }

  Text _buildHeading() {
    return Text(
      widget.home.name,
      style: const TextStyle(fontSize: 25.0),
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
    if (isNotReachableInTime(startMeansOfTransport.departureTime)) {
      return const Text(
        'Du schaffst es leider nicht mehr! :(',
        style: TextStyle(fontSize: 16.0),
      );
    }

    final TimeOfDay diffTimeToStartGoingHome = TimeTransformer.diffTime(
      startMeansOfTransport.departureTime,
      Duration(
        hours: TimeOfDay.now().hour,
        minutes: TimeOfDay.now().minute,
      ),
    );

    return Text(
      'Du musst in ${diffTimeToStartGoingHome.hour}h und ${diffTimeToStartGoingHome.minute}min loslaufen!',
      style: const TextStyle(fontSize: 16.0),
    );
  }

  bool isNotReachableInTime(TimeOfDay time) {
    return time.hour - TimeOfDay.now().hour < 0 ||
        time.minute - TimeOfDay.now().minute < 0;
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

          startMeansOfTransport = startMeansOfTransport.copyWith(
            departureTime: TimeTransformer.diffTime(
              meansOfTransportEntities.first.departureTime,
              startDuration,
            ),
          );
          endMeansOfTransport = endMeansOfTransport.copyWith(
            departureTime: TimeTransformer.addTime(
              meansOfTransportEntities.last.departureTime,
              endDuration,
            ),
          );

          // TODO: wenn in dieser Page, dann in Widget anzeigen
          updateRouteInformation([
            startMeansOfTransport,
            ...meansOfTransportEntities,
            endMeansOfTransport
          ]);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditMeansOfTransportCard(
                meansOfTransport: startMeansOfTransport,
                onEdit: (meansOfTransportEntity) {
                  _navigateToEditMeansOfTransportCardPage(
                    meansOfTransportEntity,
                    startDuration,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: BetweenMeansOfTransportCardItem(
                  duration: startDuration,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stations.length,
                separatorBuilder: (context, index) {
                  if (index == stations.length - 1) {
                    return const SizedBox.shrink();
                  }

                  final TimeOfDay duration = TimeTransformer.diffTime(
                    meansOfTransportEntities[index + 1].departureTime,
                    Duration(
                      hours: meansOfTransportEntities[index].departureTime.hour,
                      minutes:
                          meansOfTransportEntities[index].departureTime.minute,
                    ),
                  );

                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: BetweenMeansOfTransportCardItem(
                      duration: Duration(
                        hours: duration.hour,
                        minutes: duration.minute,
                      ),
                    ),
                  );
                },
                itemBuilder: (context, index) {
                  return MeansOfTransportCard(
                    station: stations[index],
                    meansOfTransport: meansOfTransportEntities[index],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: BetweenMeansOfTransportCardItem(
                  duration: endDuration,
                ),
              ),
              EditMeansOfTransportCard(
                meansOfTransport: endMeansOfTransport,
                onEdit: (meansOfTransportEntity) {
                  _navigateToEditMeansOfTransportCardPage(
                    meansOfTransportEntity,
                    endDuration,
                  );
                },
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void _navigateToEditMeansOfTransportCardPage(
    MeansOfTransportEntity meansOfTransport,
    Duration duration,
  ) async {
    final result = await Navigator.of(context).pushNamed(
      AppRouter.editMeansOfTransportCard,
      arguments: EditMeansOfTransportCardArgs(
          meansOfTransport: meansOfTransport, duration: duration),
    );

    if (result == null || !mounted) {
      return;
    }

    final resultArgs = result as EditMeansOfTransportCardArgs;
    if (meansOfTransport == startMeansOfTransport) {
      setState(() {
        startDuration = result.duration;
        startMeansOfTransport = resultArgs.meansOfTransport;
      });
    } else {
      setState(() {
        endDuration = result.duration;
        endMeansOfTransport = result.meansOfTransport;
      });
    }
  }
}
