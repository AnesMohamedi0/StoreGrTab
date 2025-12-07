import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class NewAlmostSoldOut extends StatelessWidget {
  final Color color;
  final double width;
  final String text;
  const NewAlmostSoldOut({
    super.key,
    required this.color,
    required this.width,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      color: color,
      child: AbelText(
        text: text,
        fontSize: width,
        color: textOnBlue,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
