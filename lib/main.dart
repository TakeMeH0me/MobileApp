import 'package:flutter/material.dart';
import 'package:take_me_home/widget_data_transfer_test_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: WidgetDataTransferTestPage(),
        ),
      ),
    );
  }
}
