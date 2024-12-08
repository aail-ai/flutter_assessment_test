import 'package:auto_route/auto_route.dart';
import 'package:flutter_assessment_test/core/router/routes.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class ChatAppRouter extends RootStackRouter {
  ChatAppRouter() : super();

  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: ChatRoute.page),
      ];
}
