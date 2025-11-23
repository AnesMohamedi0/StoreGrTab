import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class FilterSortButton extends StatelessWidget {
  final double size;
  final String label;
  final Icon icon;
  final VoidCallback function;
  final bool inverted;
  final bool border;
  const FilterSortButton({
    super.key,
    required this.label,
    required this.icon,
    required this.function,
    required this.size,
    this.inverted = false,
    this.border = false,
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
          color: inverted ? textOnDark : textPrimary,
          border: border
              ? Border.all(
                  color: inverted ? textPrimary : textOnDark,
                  width: 1.5,
                )
              : null,
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: size * 0.1),
            AbelText(
              text: label,
              fontSize: size * 0.3,
              fontWeight: FontWeight.bold,
              color: inverted ? textPrimary : textOnDark,
            ),
          ],
        ),
      ),
    );
  }
}
