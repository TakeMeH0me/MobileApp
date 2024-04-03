import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Theme Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildThemeSelector(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Theme:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ListTile(
          title: Text('Light Theme'),
          onTap: () {
            // Set theme to light
            _setTheme(context, ThemeMode.light);
          },
        ),
        ListTile(
          title: Text('Dark Theme'),
          onTap: () {
            // Set theme to dark
            _setTheme(context, ThemeMode.dark);
          },
        ),
      ],
    );
  }

  void _setTheme(BuildContext context, ThemeMode themeMode) {
    // Update theme using ThemeMode
    final currentRoute = ModalRoute.of(context);
    if (currentRoute != null) {
      final navigator = currentRoute.navigator;
      navigator!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SettingsPage()),
        (route) => false,
      );
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => MaterialApp(
            themeMode: themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              // Define light theme colors here
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              // Define dark theme colors here
            ),
            home: SettingsPage(),
          ),
        ),
      );
    }
  }
}
