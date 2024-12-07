// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:flutter_assessment_test/modules/chat/presentation/chat_message_screen.dart'
    as _i1;
import 'package:flutter_assessment_test/modules/home/presentation/home_screen.dart'
    as _i2;

/// generated route for
/// [_i1.ChatScreen]
class ChatRoute extends _i3.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i4.Key? key,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<ChatRouteArgs>(orElse: () => const ChatRouteArgs());
      return _i1.ChatScreen(key: args.key);
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}