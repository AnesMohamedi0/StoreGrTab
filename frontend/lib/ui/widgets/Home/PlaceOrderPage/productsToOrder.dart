import 'package:flutter/material.dart';
import 'package:grtabstore/providers/HomeProviders/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/ProductDisplay/ProductHorizontalDisplay.dart';
import 'package:grtabstore/ui/widgets/Shared/infoDialog.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class ProductsToOrder extends StatelessWidget {
  const ProductsToOrder({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.shopping_cart, color: textSecondary, size: width * 0.06),
            SizedBox(width: width * 0.01),
            AbelText(
              text: 'Items To Order:',
              fontSize: width * 0.038,
              color: textSecondary,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return InfoDialog(
                      title: 'Items To Order',
                      description:
                          'You can add products to your order by clicking on the "Add to Order" button on each product page',
                    );
                  },
                );
              },
              icon: Icon(Icons.info, color: textTertiary, size: width * 0.04),
            ),
          ],
        ),
        Consumer<OrderProvider>(
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
        ),
      ],
    );
  }
}
