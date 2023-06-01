import 'package:tranquillo/data/classes.dart';
import 'package:tranquillo/presentation/browse_screen.dart';
import 'package:tranquillo/presentation/compare_screen.dart';
import 'package:tranquillo/presentation/login/login_screen.dart';
import 'package:tranquillo/presentation/create_screen.dart';
import 'package:tranquillo/presentation/preview_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final allRoutes = [
    AppRoutes.homepage,
    AppRoutes.create,
    AppRoutes.browse,
    AppRoutes.preview,
    AppRoutes.compare
  ];

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    AppRoute appRoute = allRoutes.firstWhere(
      (appRoute) => appRoute.route == routeSettings.name,
    );

    return PageRouteBuilder<void>(
      settings: routeSettings,
      pageBuilder: (context, animation, secondaryAnimation) => appRoute.build(
        context,
        routeSettings.arguments,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

class AppRoute {
  const AppRoute({
    required this.build,
    required this.route,
  });

  final Widget Function(BuildContext context, Object? arguments) build;
  final String route;
}

class AppRoutes {
  static final homepage = AppRoute(
    build: (_, __) => LoginScreen(),
    route: '/',
  );
  static final create = AppRoute(
    build: (_, __) => const CreateScreen(),
    route: '/create',
  );
  static final browse = AppRoute(
    build: (_, __) => const BrowseScreen(),
    route: '/browse',
  );
  static final preview = AppRoute(
    build: (_, __) => const PreviewScreen(),
    route: '/preview',
  );
  static final compare = AppRoute(
    build: (_, __) {
      final args = ModalRoute.of(_)!.settings.arguments as List<Dictando>;
      return CompareScreen(
        dictandoA: args[0],
        dictandoB: args[1],
      );
    },
    route: '/compare',
  );
}
