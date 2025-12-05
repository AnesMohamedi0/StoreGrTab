import 'package:flutter/material.dart';

class DesktopAdminPage extends StatelessWidget {
  const DesktopAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desktop Admin'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          "I'm on desktop",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
