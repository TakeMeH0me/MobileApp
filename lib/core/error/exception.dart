/// Custom [Exception] to handle API related errors.
class APIException implements Exception {
  final String message;

  APIException({required this.message});

  @override
  String toString() => message;
}
