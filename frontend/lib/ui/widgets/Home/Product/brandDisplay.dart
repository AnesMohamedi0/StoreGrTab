import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/brand.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class BrandDisplay extends StatelessWidget {
  final Brand brand;
  final double width;
  const BrandDisplay({super.key, required this.brand, required this.width});

  @override
  Widget build(BuildContext context) {
    if (brand.brandId == 0) {
      return AbelText(
        text: 'Unknown Brand',
        fontSize: width * 0.065,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      );
    } else {
      return Row(
        children: [
          AbelText(
            text: brand.name,
            fontSize: width * 0.065,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
          SizedBox(width: width * 0.01),
          SizedBox(
            width: width * 0.1,
            height: width * 0.1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: (brand.photoUrl != null && brand.photoUrl!.isNotEmpty)
                  ? Image.network(
                      brand.photoUrl!,
                      width: width * 0.15,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.tablet,
                            size: width * 0.05,
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.tablet,
                        size: width * 0.05,
                        color: Colors.grey[600],
                      ),
                    ),
            ),
          ),
        ],
      );
    }
  }
}
