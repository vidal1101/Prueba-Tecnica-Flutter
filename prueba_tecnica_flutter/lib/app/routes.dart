import 'package:flutter/material.dart';
import 'package:prueba_tecnica_flutter/domain/entities/local_image_entity.dart';
import 'package:prueba_tecnica_flutter/presentation/screen/screen.dart';

class AppRoutes {
  static const splash = '/';
  static const home = '/home';

  // API
  static const apiList = '/api-list';

  // PREFS (SQLite)
  static const prefsList = '/prefs';
  static const prefsDetail = '/prefs/detail';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _page(const SplashScreen());

      case AppRoutes.home:
        return _page(const HomeScreen());

      // ----------------------
      // *** API screens ***
      // ----------------------
      case AppRoutes.apiList:
        return _page(const ApiListScreen());

      // ----------------------
      // *** PREFS (SQLite) ***
      // ----------------------
      case AppRoutes.prefsList:
        return _page(const PrefsListScreen());


      case AppRoutes.prefsDetail:
        final item = settings.arguments as LocalImageEntity;
        return _page(PrefsDetailScreen(image: item));

      default:
        return _page(
          const Scaffold(
            body: Center(child: Text("Ruta no encontrada")),
          ),
        );
    }
  }
}

PageRoute _page(Widget view) {
  return MaterialPageRoute(builder: (_) => view);
}
