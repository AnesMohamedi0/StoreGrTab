import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: AbelText(text: title, fontSize: width * 0.05),
      content: AbelText(
        text: description,
        color: textSecondary,
        fontSize: width * 0.03,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: AbelText(text: 'Got it', fontSize: width * 0.04),
        ),
      ],
    );
  }
}
