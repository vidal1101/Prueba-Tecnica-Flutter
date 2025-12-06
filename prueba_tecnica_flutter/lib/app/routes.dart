import 'package:flutter/material.dart';
import 'package:prueba_tecnica_flutter/presentation/screen/screen.dart';



class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const apiList = '/api-list';
  static const prefsList = '/prefs';
  static const prefsNew = '/prefs/new';
  static const prefsDetail = '/prefs/detail';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _page(const SplashScreen());

      case AppRoutes.home:
        return _page(const HomeScreen());

    
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
