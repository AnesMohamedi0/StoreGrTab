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
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.attach_money, color: textPrimary, size: width * 0.05),
              SizedBox(width: width * 0.01),
              AbelText(
                text: 'Price:',
                fontSize: width * 0.048,
                color: textPrimary,
              ),
            ],
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(left: width * 0.01),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (product.oldPrice != null)
                  AbelText(
                    text: '${product.oldPrice!.toStringAsFixed(0)} DA',
                    fontSize: width * 0.04,
                    color: textTertiary,
                    fontWeight: FontWeight.w400,
                    lineThrough: true,
                  ),
                if (product.oldPrice != null) SizedBox(width: width * 0.015),
                AbelText(
                  text: product.price.toStringAsFixed(0),
                  fontSize: width * 0.06,
                  color: textSecondary,
                  fontWeight: FontWeight.bold,
                ),
                AbelText(
                  text: ' DA',
                  fontSize: width * 0.057,
                  color: textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
