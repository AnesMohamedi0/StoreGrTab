import 'package:flutter/material.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class SocialMediaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String? label;
  const SocialMediaButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.032;
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          icon,
          SizedBox(width: width * 0.3),
          if (label != null)
            TitlesText(
              text: label!,
              color: Colors.white,
              fontSize: width,
              fontWeight: FontWeight.normal,
            ),
        ],
      ),
    );
  }
}
