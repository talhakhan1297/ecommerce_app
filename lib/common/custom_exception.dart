class CustomException implements Exception {
  const CustomException(
    this._message,
    this._prefix,
  );

  final String? _message;
  final String _prefix;

  String get message => _message ?? 'Something went wrong';

  @override
  String toString() {
    return '$_prefix $_message';
  }
}
