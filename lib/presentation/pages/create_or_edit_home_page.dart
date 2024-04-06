import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/presentation/bloc/home/home_bloc.dart';
import 'package:take_me_home/presentation/widgets/edit_card.dart';

/// A home can be created ([isEditing] = false) or edited ([isEditing] = true) with this page.
///
/// Adjusts the UI based on the [isEditing] value.
class CreateOrEditHomePage extends StatefulWidget {
  final HomeEntity home;
  final bool isNewHome;

  const CreateOrEditHomePage({
    super.key,
    required this.home,
    required this.isNewHome,
  });

  @override
  State<CreateOrEditHomePage> createState() => _CreateOrEditHomePageState();
}

class _CreateOrEditHomePageState extends State<CreateOrEditHomePage> {
  late HomeEntity currentHome = widget.home;

  late final TextEditingController _homeNameController = TextEditingController(
    text: widget.home.name,
  );
  late final TextEditingController _streetController = TextEditingController(
    text: widget.home.street,
  );
  late final TextEditingController _streetNumberController =
      TextEditingController(
    text: widget.home.streetNumber,
  );
  late final TextEditingController _postcodeController = TextEditingController(
    text: widget.home.postcode.toString(),
  );
  late final TextEditingController _cityController = TextEditingController(
    text: widget.home.city,
  );

  final List<StationEntity> _stations = [
    const StationEntity(
      id: '8012657',
      name: 'Pößneck ob Bf',
    ),
    const StationEntity(
      id: '8011957',
      name: 'Jena West',
    ),
    const StationEntity(
      id: '8010101',
      name: 'Erfurt Hbf',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _homeNameController.addListener(_onHomeNameChanged);
    _streetController.addListener(_onStreetChanged);
    _streetNumberController.addListener(_onNumberChanged);
    _postcodeController.addListener(_onPostcodeChanged);
    _cityController.addListener(_onCityChanged);

    if (currentHome.mainStation == const StationEntity.empty()) {
      currentHome = currentHome.copyWith(mainStation: _stations.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStationSelectionEditCard(),
                  _buildHomeEditCard(),
                  _buildCityEditCard(),
                  _buildStreetEditCard(),
                  _buildStreetNumberEditCard(),
                  _buildPostCodeEditCard(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  @override
  void dispose() {
    _homeNameController.dispose();
    _streetController.dispose();
    _streetNumberController.dispose();
    _postcodeController.dispose();
    _cityController.dispose();

    super.dispose();
  }

  EditCard _buildStationSelectionEditCard() {
    return EditCard(
      leadingIcon: const Icon(Icons.train),
      mainContent: _buildStationSelection(),
    );
  }

  EditCard _buildHomeEditCard() {
    return EditCard(
      mainContent: TextField(
        controller: _homeNameController,
        decoration: const InputDecoration(
          labelText: 'Home',
        ),
      ),
    );
  }

  EditCard _buildCityEditCard() {
    return EditCard(
      mainContent: TextField(
        controller: _cityController,
        decoration: const InputDecoration(
          labelText: 'City',
        ),
      ),
    );
  }

  EditCard _buildStreetEditCard() {
    return EditCard(
      mainContent: TextField(
        controller: _streetController,
        decoration: const InputDecoration(
          labelText: 'Street',
        ),
      ),
    );
  }

  EditCard _buildStreetNumberEditCard() {
    return EditCard(
      mainContent: TextField(
        controller: _streetNumberController,
        decoration: const InputDecoration(
          labelText: 'Street Number',
        ),
        maxLength: 4,
      ),
    );
  }

  EditCard _buildPostCodeEditCard() {
    return EditCard(
      mainContent: TextField(
        controller: _postcodeController,
        decoration: const InputDecoration(
          labelText: 'Postcode',
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 5,
        keyboardType: TextInputType.number,
      ),
    );
  }

  DropdownButton<StationEntity> _buildStationSelection() {
    return DropdownButton(
      items: _stations
          .map(
            (station) => DropdownMenuItem(
              value: station,
              child: Text(station.name),
            ),
          )
          .toList(),
      value: currentHome.mainStation,
      onChanged: (value) {
        setState(() {
          currentHome = currentHome.copyWith(mainStation: value);
        });
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          if (widget.isNewHome) {
            _sendCreateHome();
          } else {
            _sendUpdateHome();
          }

          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  void _sendCreateHome() {
    BlocProvider.of<HomeBloc>(context).add(
      CreateHomeEvent(home: currentHome),
    );
  }

  void _sendUpdateHome() {
    BlocProvider.of<HomeBloc>(context).add(
      UpdateHomeEvent(home: currentHome),
    );
  }

  _onHomeNameChanged() {
    setState(() {
      currentHome = currentHome.copyWith(name: _homeNameController.text);
    });
  }

  _onStreetChanged() {
    setState(() {
      currentHome = currentHome.copyWith(street: _streetController.text);
    });
  }

  _onNumberChanged() {
    setState(() {
      currentHome =
          currentHome.copyWith(streetNumber: _streetNumberController.text);
    });
  }

  _onPostcodeChanged() {
    setState(() {
      currentHome = currentHome.copyWith(postcode: _postcodeController.text);
    });
  }

  _onCityChanged() {
    setState(() {
      currentHome = currentHome.copyWith(city: _cityController.text);
    });
  }
}
