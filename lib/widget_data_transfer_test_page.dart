import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:take_me_home/widget_data_transfer_test_types.dart';
import 'package:take_me_home/widget_data_transfer_test_types.dart' as types;

class WidgetDataTransferTestPage extends StatefulWidget {
  static const String appGroupId = 'group.takemehome';
  const WidgetDataTransferTestPage({super.key});

  @override
  State<StatefulWidget> createState() => _WidgetDataTransferTestPageState();
}

class _WidgetDataTransferTestPageState
    extends State<WidgetDataTransferTestPage> {
  types.RouteInformation? _routeInformation;

  void updateRouteInformation(types.RouteInformation? routeInformation) {
    print(routeInformation?.toJson().toString());

    HomeWidget.setAppGroupId(WidgetDataTransferTestPage.appGroupId);
    HomeWidget.saveWidgetData<String>(
        'routeinformation_json', routeInformation?.toJson().toString());

    HomeWidget.updateWidget(
      iOSName: 'takeMeHomeWidget',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialButton(
          child: Text(_routeInformation == null ? 'Start Route' : 'Stop Route'),
          onPressed: () {
            if (_routeInformation == null) {
              _routeInformation = types.RouteInformation(
                  date: DateTime.fromMicrosecondsSinceEpoch(1708526700),
                  route: [
                    types.RoutePart(
                        vehicle: VehicleType.tram,
                        lineName: "3",
                        lineDestination: "Friedrich Engels Straße",
                        entrance: "DHGE",
                        entranceTime:
                            DateTime.fromMicrosecondsSinceEpoch(1708523280),
                        exit: "Friedrich Engels Straße",
                        exitTime:
                            DateTime.fromMicrosecondsSinceEpoch(1708524000)),
                    types.RoutePart(
                        vehicle: VehicleType.walk,
                        lineName: "",
                        lineDestination: "",
                        entrance: "Friedrich Engels Straße",
                        entranceTime:
                            DateTime.fromMicrosecondsSinceEpoch(1708524000),
                        exit: "Gera Hbf",
                        exitTime:
                            DateTime.fromMicrosecondsSinceEpoch(1708524300)),
                    types.RoutePart(
                        vehicle: VehicleType.train,
                        lineName: "RE1",
                        lineDestination: "Göttingen",
                        entrance: "Gera Hbf",
                        entranceTime:
                            DateTime.fromMicrosecondsSinceEpoch(1708524300),
                        exit: "Erfurt Hbf",
                        exitTime:
                            DateTime.fromMicrosecondsSinceEpoch(1708526700)),
                    types.RoutePart(
                        vehicle: VehicleType.tram,
                        lineName: "5",
                        lineDestination: "Zoopark",
                        entrance: "Erfurt Hbf",
                        entranceTime:
                            DateTime.fromMicrosecondsSinceEpoch(1708526700),
                        exit: "Lutherkirche",
                        exitTime:
                            DateTime.fromMicrosecondsSinceEpoch(1708527300)),
                    types.RoutePart(
                        vehicle: VehicleType.walk,
                        lineName: "",
                        lineDestination: "",
                        entrance: "Lutherkirche",
                        entranceTime:
                            DateTime.fromMicrosecondsSinceEpoch(1708527300),
                        exit: "Schobersmühlenweg",
                        exitTime:
                            DateTime.fromMicrosecondsSinceEpoch(1708527600)),
                  ]);
              updateRouteInformation(_routeInformation);
              setState(() {});
            } else {
              _routeInformation = null;
              updateRouteInformation(_routeInformation);
              setState(() {});
            }
          }),
    );
  }
}
