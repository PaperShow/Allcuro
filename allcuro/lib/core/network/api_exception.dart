/// A normalized error surfaced by [ApiClient] so repositories never have to
/// deal with Dio's exception types directly.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException($statusCode): $message';
}
