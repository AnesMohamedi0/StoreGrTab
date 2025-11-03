import 'package:flutter/material.dart';

class LogoDisplay extends StatelessWidget {
  final double size;
  const LogoDisplay({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size * 0.1),
      width: double.infinity,
      alignment: Alignment.center,
      child: Image.asset('assets/logo.png', height: size, color: Colors.white),
    );
  }
}
