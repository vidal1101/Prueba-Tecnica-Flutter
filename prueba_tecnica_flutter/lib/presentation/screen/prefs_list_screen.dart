
import 'package:flutter/material.dart';

class PrefsListScreen extends StatelessWidget {
  const PrefsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de preferencias"),
      ),
      body: const Center(
        child: Text("Lista de preferencias"),
      ),
    );
  }
}