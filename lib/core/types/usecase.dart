import 'package:flutter/material.dart';
import 'package:flutter_assessment_test/core/exceptions/base_error.dart';
import 'package:flutter_assessment_test/core/exceptions/internet_failed_exception.dart';
import 'package:flutter_assessment_test/core/types/resource.dart';

/// ```dart
/// class TestUseCase extends Usecase<NoParams, int> {
///  @override
///  Future<Resource<int>> execute(NoParams params) async {
///    await Future.delayed(const Duration(seconds: 5));
///    return Resource.success(1, "");
///  }
/// }
/// ```
///
///
abstract class UseCase<Params, Result> {
  Future<Resource<Result>> execute(Params params);

  Future<Resource<Result>> call(Params params) async {
    try {
      final result = await execute(params);
      return result;
    } catch (e, stacktrace) {
      debugPrint("ERROR IN USECASE $e\nSTACKTRACE: $stacktrace");

      return await handleError(e, stacktrace);
    }
  }

  Future<Resource<Result>> handleError(Object e, StackTrace stackTrace) async {
    return _handleError(e, stackTrace);
  }
}

abstract class UsecaseNoParams<Result> {
  Future<Resource<Result>> execute();

  Future<Resource<Result>> call() async {
    try {
      final result = await execute();
      return result;
    } catch (e, stacktrace) {
      debugPrint("ERROR IN USECASE $e\nSTACKTRACE: $stacktrace");

      return await handleError(e, stacktrace);
    }
  }

  Future<Resource<Result>> handleError(Object e, StackTrace stackTrace) async {
    return _handleError(e, stackTrace);
  }
}

Future<Resource<Result>> _handleError<Result>(Object e, StackTrace stackTrace) async {
  if (e is! BaseError) {
    return Resource.error(BaseError.unknownError());
  } else if (e is InternetFailedException) {
    throw e;
  }
  return Resource.error(e);
}
