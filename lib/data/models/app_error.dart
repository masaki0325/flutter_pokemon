class AppError implements Exception {
  final String message;
  final int? code;
  final ErrorType type;

  AppError(this.message, [this.code, this.type = ErrorType.general]);

  @override
  String toString() => 'AppError(message: $message, code: $code, type: $type)';
}

enum ErrorType {
  network,
  timeout,
  server,
  general,
}
