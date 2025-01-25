import 'package:flutter/material.dart';
import '../../constants/route_constants.dart';
import '../../features/view/allOrdersView.dart';
import '../../features/view/logInView.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteConstants.allOrders:
        return MaterialPageRoute(builder: (_) => const AllOrdersView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
} 