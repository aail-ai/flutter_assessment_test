import 'package:flutter_assessment_test/core/exceptions/base_error.dart';
import 'package:flutter_assessment_test/core/types/resource.dart';

extension ResourceExt<T> on Resource<T> {
  void when({required void Function(T data) success,required void Function(BaseError exception) error}) {
    if (this is Success<T>) {
      success((this as Success<T>).data);
    } else if (this is Error<T>) {
      error((this as Error<T>).exception);
    }
  }
}
