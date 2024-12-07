class BaseError implements Exception {
  final String message;
  final StackTrace? stackTrace;
  BaseError({
    this.message = 'Failed to load data, please try again later!',
    this.stackTrace,
  });

  @override
  String toString() => message;

  factory BaseError.unknownError() =>  BaseError(message: 'Something went wrong, please try again later!');

}
