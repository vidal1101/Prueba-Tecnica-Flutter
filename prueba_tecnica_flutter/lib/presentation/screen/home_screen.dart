import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:prueba_tecnica_flutter/app/routes.dart';
import 'package:prueba_tecnica_flutter/presentation/widgets/widgets.dart';

/// HomeScreen
/// 
/// This class represents the home screen of the application.
/// It displays a list of menu items with fade-in animations.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Menú principal",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: [
          FadeInLeft(
            delay: const Duration(milliseconds: 300),
            child: MenuCard(
              title: "Datos de la API",
              subtitle: "Consultar lista remota de imágenes",
              icon: Icons.cloud_outlined,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.apiList);
              },
            ),
          ),

          FadeInRight(
            delay: const Duration(milliseconds: 300),
            child: MenuCard(
              title: "Preferencias",
              subtitle: "CRUD con base de datos local SQLite",
              icon: Icons.settings_outlined,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.prefsList);
              },
            ),
          ),
        ],
      ),
    );
  }
}
