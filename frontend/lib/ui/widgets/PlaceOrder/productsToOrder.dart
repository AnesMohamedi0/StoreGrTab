import 'package:flutter/material.dart';
import 'package:grtabstore/providers/orderProvider.dart';
import 'package:grtabstore/ui/widgets/Home/Product/ProductHorizontalDisplay.dart';
import 'package:provider/provider.dart';

class ProductsToOrder extends StatelessWidget {
  const ProductsToOrder({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<OrderProvider>(
      builder: (context, provider, _) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: provider.products.length,
          itemBuilder: (context, index) {
            final product = provider.products[index];
            final item = product.$1;
            final quantity = product.$2;

            return ProductHorizontalDisplay(
              product: item,
              height: height * 0.09,
              count: quantity,
              order: true,
              canDelete: provider.canDeleteProduct(),
            );
          },
        );
      },
    );
  }
}
