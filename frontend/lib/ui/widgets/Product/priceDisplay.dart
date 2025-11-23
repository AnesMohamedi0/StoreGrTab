import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class PriceDisplay extends StatelessWidget {
  final Product product;

  const PriceDisplay({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AbelText(
            text: product.price.toStringAsFixed(0),
            fontSize: width * 0.07,
            color: textPrimary,
            fontWeight: FontWeight.bold,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AbelText(
                text: ' DA',
                fontSize: width * 0.065,
                color: textPrimary,
                fontWeight: FontWeight.bold,
              ),
              if (product.oldPrice != null) SizedBox(width: width * 0.02),
              if (product.oldPrice != null)
                AbelText(
                  text: '${product.oldPrice!.toStringAsFixed(0)} DA',
                  fontSize: width * 0.04,
                  color: textTertiary,
                  fontWeight: FontWeight.w400,
                  lineThrough: true,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
