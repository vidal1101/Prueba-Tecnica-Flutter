
import 'package:flutter/material.dart';

class PrefsNewScreen extends StatelessWidget {
  const PrefsNewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva preferencia"),
      ),
      body: const Center(
        child: Text("Nueva preferencia"),
      ),
    );
  }
}