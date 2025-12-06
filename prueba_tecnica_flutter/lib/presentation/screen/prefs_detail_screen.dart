


import 'package:flutter/material.dart';

class PrefsDetailScreen extends StatelessWidget {

  final int id;
  const PrefsDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle de preferencia"),
      ),
      body: const Center(
        child: Text("Detalle de preferencia"),
      ),
    );
  }
}