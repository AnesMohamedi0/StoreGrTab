import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class PanelButton extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback onPressed;
  const PanelButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: width * 0.02,
          horizontal: width * 0.04,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [secondaryBackground, primaryBackground],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: textSecondary, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: width * 0.02),
            AbelText(text: text, fontSize: width * 0.04),
          ],
        ),
      ),
    );
  }
}
