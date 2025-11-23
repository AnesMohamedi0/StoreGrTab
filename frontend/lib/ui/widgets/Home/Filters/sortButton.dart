import 'package:flutter/material.dart';
import 'package:grtabstore/providers/productsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class SortButton extends StatelessWidget {
  final bool isSelected;
  final double size;
  final bool ascending;
  final String label;
  final Icon icon;
  final VoidCallback? function;

  const SortButton({
    super.key,
    required this.size,
    required this.ascending,
    required this.label,
    required this.icon,
    this.function,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
          function ??
          () {
            context.read<ProductsProvider>().sortByName(ascending: ascending);
          },
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.circle_rounded : Icons.circle_outlined,
            size: size * 0.045,
            color: textSecondary,
          ),
          SizedBox(width: size * 0.02),
          AbelText(text: label, fontSize: size * 0.045),
          SizedBox(width: size * 0.02),
          icon,
          Icon(
            ascending ? Icons.arrow_downward : Icons.arrow_upward,
            size: size * 0.045,
            color: textSecondary,
          ),
        ],
      ),
    );
  }
}
