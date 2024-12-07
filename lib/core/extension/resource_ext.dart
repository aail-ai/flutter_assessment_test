import 'package:flutter_assessment_test/core/exceptions/base_error.dart';
import 'package:flutter_assessment_test/core/types/resource.dart';

extension ResourceExt<T> on Resource<T> {
  void fold(void Function(T data) onSuccess, void Function(BaseError exception) onError) {
    if (this is Success<T>) {
      onSuccess((this as Success<T>).data);
    } else if (this is Error<T>) {
      onError((this as Error<T>).exception);
    }
  }
}
