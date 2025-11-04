import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class FilterSortButton extends StatelessWidget {
  final double size;
  final String label;
  final Icon icon;
  final VoidCallback function;
  const FilterSortButton({
    super.key,
    required this.label,
    required this.icon,
    required this.function,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: function,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size * 0.1,
          vertical: size * 0.05,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: textPrimary,
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: size * 0.1),
            AbelText(
              text: label,
              fontSize: size * 0.3,
              fontWeight: FontWeight.bold,
              color: textOnDark,
            ),
          ],
        ),
      ),
    );
  }
}
