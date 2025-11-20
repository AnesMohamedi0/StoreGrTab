import 'package:flutter/material.dart';

class LogoDisplay extends StatelessWidget {
  final double size;
  final bool padding;
  const LogoDisplay({super.key, required this.size, this.padding = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ? EdgeInsets.all(size * 0.1) : EdgeInsets.zero,
      width: double.infinity,
      alignment: Alignment.center,
      child: Image.asset('assets/logo.png', height: size, color: Colors.white),
    );
  }
}
