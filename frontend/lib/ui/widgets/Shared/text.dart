import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitlesText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const TitlesText({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dancingScript(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
