import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/brand.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class BrandDisplay extends StatelessWidget {
  final Brand brand;
  final double width;
  final Color color;
  const BrandDisplay({
    super.key,
    required this.brand,
    required this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AbelText(
          text: brand.name,
          fontSize: width * 0.065,
          fontWeight: FontWeight.bold,
          color: color,
        ),
        SizedBox(width: width * 0.01),
        SizedBox(
          width: width * 0.1,
          height: width * 0.1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: Image.network(brand.photoUrl ?? '', width: width * 0.15),
          ),
        ),
      ],
    );
  }
}
