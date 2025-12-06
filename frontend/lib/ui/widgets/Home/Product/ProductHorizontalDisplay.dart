import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/providers/HomeProviders/cartProvider.dart';
import 'package:grtabstore/providers/HomeProviders/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class ProductHorizontalDisplay extends StatelessWidget {
  final Product product;
  final double height;
  final int count;
  final bool order;
  final bool canDelete;
  const ProductHorizontalDisplay({
    super.key,
    required this.product,
    required this.height,
    this.count = 1,
    this.order = false,
    this.canDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: height * 0.8,
                height: height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: textPrimary),
                  image: DecorationImage(
                    image: NetworkImage(product.photoUrl[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: width * 0.04),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AbelText(
                    text: product.name,
                    fontSize: width * 0.043,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (product.oldPrice != null)
                        AbelText(
                          text: '${product.oldPrice?.toStringAsFixed(0)}DA ',
                          fontSize: width * 0.032,
                          color: textTertiary,
                          lineThrough: true,
                        ),
                      AbelText(
                        text: '${product.price.toStringAsFixed(0)} DA',
                        fontSize: width * 0.035,
                        color: textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (order) {
                    Provider.of<OrderProvider>(
                      context,
                      listen: false,
                    ).addProduct(product);
                  } else {
                    Provider.of<CartProvider>(
                      context,
                      listen: false,
                    ).addProduct(product);
                  }
                },
                icon: Icon(
                  Icons.add,
                  color: textSecondary,
                  size: width * 0.048,
                ),
              ),
              AbelText(
                text: '$count',
                fontSize: width * 0.045,
                fontWeight: FontWeight.bold,
              ),
              if (count > 1)
                IconButton(
                  onPressed: () {
                    if (order) {
                      Provider.of<OrderProvider>(
                        context,
                        listen: false,
                      ).decrementCountProduct(product);
                    } else {
                      Provider.of<CartProvider>(
                        context,
                        listen: false,
                      ).decrementCountProduct(product);
                    }
                  },
                  icon: Icon(
                    Icons.remove,
                    color: textSecondary,
                    size: width * 0.048,
                  ),
                ),
              SizedBox(width: width * 0.02),
              IconButton(
                onPressed: !canDelete
                    ? null
                    : () {
                        if (order) {
                          Provider.of<OrderProvider>(
                            context,
                            listen: false,
                          ).removeProduct(product);
                        } else {
                          Provider.of<CartProvider>(
                            context,
                            listen: false,
                          ).removeProduct(product);
                        }
                      },
                icon: Icon(
                  Icons.delete,
                  color: canDelete ? accentError : textTertiary,
                  size: width * 0.048,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
