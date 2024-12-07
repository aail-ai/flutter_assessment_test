
import 'package:flutter/material.dart';
import 'package:flutter_assessment_test/core/exceptions/base_error.dart';

class InternetFailedException extends BaseError {
  InternetFailedException({
    super.message = 'Failed to connect to server!',
  }) {
    debugPrint(super.message);
  }

  @override
  String toString() => message;
}
