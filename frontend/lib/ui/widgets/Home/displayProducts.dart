import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class ProductDisplay extends StatelessWidget {
  final Product product;
  final double width;
  final double height;
  const ProductDisplay({
    super.key,
    required this.product,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Image.network(product.photoUrl ?? '', fit: BoxFit.cover),
          Positioned(
            left: width * 0.05,
            bottom: height * 0.05,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitlesText(
                  text: product.name,
                  fontSize: height * 0.1,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
                Text('${product.price.toStringAsFixed(2)} DA'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
