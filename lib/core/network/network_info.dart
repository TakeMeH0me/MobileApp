import 'package:internet_connection_checker/internet_connection_checker.dart';

/// A class to check if the device is connected to the internet.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// An implementation of [NetworkInfo] that uses [InternetConnectionChecker] to check if the device is connected to the internet.
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
