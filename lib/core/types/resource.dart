
import 'package:flutter_assessment_test/core/exceptions/base_error.dart';

sealed class Resource<T> {
  static Resource<T> success<T>(T data) => Success<T>(data: data);

  static Resource<T> error<T>(BaseError exception) => Error<T>(exception);
}

class Success<T> extends Resource<T> {
  final T data;

  Success({required this.data});
}

class Error<T> extends Resource<T> {
  final BaseError exception;

  Error(this.exception);
}


