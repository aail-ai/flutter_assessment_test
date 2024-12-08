import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

extension AutoRouteExtension on BuildContext {
  StackRouter get router => AutoRouter.of(this);
}
