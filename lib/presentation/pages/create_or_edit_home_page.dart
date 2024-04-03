import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/presentation/theme/color_themes.dart';

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

  @override
  void initState() {
    super.initState();

    //instead of onChanged in Textfield
    _homeNameController.addListener(_onHomeNameChanged);
    _streetController.addListener(_onStreetChanged);
    _streetNumberController.addListener(_onNumberChanged);
    _postcodeController.addListener(_onPostcodeChanged);
    _cityController.addListener(_onCityChanged);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Create Or Edit Home Page'),
            Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Card(
                        color: lightColorTheme.colorScheme.surface,
                        child: ListTile(
                          title: TextField(
                            controller: _homeNameController,
                            decoration: const InputDecoration(
                              labelText: 'Home Name',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Card(
                          color: lightColorTheme.colorScheme.surface,
                          child: ListTile(
                            title: TextField(
                              controller: _streetController,
                              decoration: const InputDecoration(
                                labelText: 'Street',
                              ),
                            ),
                          )),
                      const SizedBox(height: 10.0),
                      Card(
                          color: lightColorTheme.colorScheme.surface,
                          child: ListTile(
                            title: TextField(
                              controller: _streetNumberController,
                              decoration: const InputDecoration(
                                labelText: 'Street Number',
                              ),
                              maxLength: 4,
                            ),
                          )),
                      const SizedBox(height: 10.0),
                      Card(
                          color: lightColorTheme.colorScheme.surface,
                          child: ListTile(
                            title: TextField(
                              controller: _postcodeController,
                              decoration: const InputDecoration(
                                labelText: 'Postcode',
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 5,
                              keyboardType: TextInputType.number,
                            ),
                          )),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(currentHome);
        },
        child: const Icon(Icons.save),
      ),
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
