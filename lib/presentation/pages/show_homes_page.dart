import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/presentation/pages/settings_page.dart';
import 'package:take_me_home/presentation/router/args/create_or_edit_home_args.dart';
import 'package:take_me_home/presentation/router/app_router.dart';
import 'package:take_me_home/presentation/router/args/show_way_to_home_args.dart';
import 'package:take_me_home/presentation/widgets/current_location_card.dart';
import 'package:take_me_home/presentation/widgets/widgets.dart';

/// Shows all created homes.
class ShowHomesPage extends StatefulWidget {
  const ShowHomesPage({super.key});

  @override
  State<ShowHomesPage> createState() => _ShowHomesPageState();
}

class _ShowHomesPageState extends State<ShowHomesPage> {
  void _deleteHome(String id) {
    setState(() {
      _homes.removeWhere((home) => home.id == id);
    });
  }

  final List<HomeEntity> _homes = [
    const HomeEntity(
      id: '1',
      name: 'Freundin',
      city: 'Gera',
      street: 'Test Street',
      streetNumber: '55a',
      postcode: '75683',
    ),
    const HomeEntity(
      id: '2',
      name: 'Elternhaus',
      city: 'Pößneck',
      street: 'Test Street',
      streetNumber: '63a',
      postcode: '07381',
    ),
    const HomeEntity(
      id: '3',
      name: 'Eigene Wohung',
      city: 'Jena',
      street: 'Coole Streeeeeeeeeeeeeeeeeeeeeeet',
      streetNumber: '99',
      postcode: '92379',
    ),
    const HomeEntity(
      id: '4',
      name: 'Anwesen in den Bergen',
      city: 'Berchtesgaden',
      street: 'An der Kuhglocke',
      streetNumber: '13c',
      postcode: '12345',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const CurrentLocationCard(
            startStation: 'Gera DHGE',
            distance: '',
            departureArrival: 'Weg der Freundschaft 4',
            leadingIcon: Icon(Icons.gps_fixed),
            trailingIcon: Icon(Icons.edit),
            onResult: onResultRecieved,
            track: '07546 Gera',
          ),
          SizedBox(
            height: 20,
          ),
          ..._getHomeWidgets(context),
        ]),
      ),
    );
  }

  List<Widget> _getHomeWidgets(BuildContext context) {
    List<Widget> homeCardsWithSpaces = [];
    for (final HomeEntity home in _homes) {
      final Widget dismissibleCard = Dismissible(
        key: Key(home.id), // Unique key for Dismissible
        direction: DismissDirection.endToStart, // Swipe direction
        onDismissed: (direction) {
          // Callback when the item is dismissed
          _deleteHome(home.id);
        },
        background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.delete, color: Colors.white)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.90,
          height: 75.0,
          child: HomeButton(
            homeName: home.name,
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRouter.showWayToHome,
                arguments: ShowWayToHomeArgs(home: home),
              );
            },
            onTrailingPressed: () {
              _navigateToCreateOrEditHomePage(context, home);
            },
          ),
        ),
      );

      homeCardsWithSpaces.add(dismissibleCard);
      homeCardsWithSpaces.add(const SizedBox(height: 10.0));
    }

    return homeCardsWithSpaces;
  }

  Future<void> _navigateToCreateOrEditHomePage(
    BuildContext context,
    HomeEntity home,
  ) async {
    final newHome = await Navigator.of(context).pushNamed(
      AppRouter.createOrEditHome,
      arguments: CreateOrEditHomeArgs(
        home: home,
        isNewHome: false,
      ),
    );

    if (!context.mounted || newHome == null) {
      return;
    }

    final int indexOfOldHome = _homes.indexOf(home);
    setState(() {
      _homes.removeAt(indexOfOldHome);
      _homes.insert(indexOfOldHome, newHome as HomeEntity);
    });
  }
}

TimeOfDay onResultRecieved(dynamic result) {
  TimeOfDay time = TimeOfDay(hour: result.hour, minute: result.minute);

  return time;
}
