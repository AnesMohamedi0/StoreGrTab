import 'package:flutter/material.dart';
import 'package:grtabstore/providers/productsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class CartModal extends StatelessWidget {
  const CartModal({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(height * 0.04),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      width: width,
      child: Consumer<ProductsProvider>(
        builder: (context, provider, _) {
          if (provider.shoppingCart.isEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: width * 0.05,
                  color: textSecondary,
                ),
                SizedBox(width: width * 0.02),
                AbelText(
                  text: "Your cart is empty.",
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: textSecondary,
                ),
              ],
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      size: width * 0.04,
                      color: textPrimary,
                    ),
                    SizedBox(width: width * 0.02),
                    AbelText(
                      text: "Items in your cart: ",
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Container(
                  height: height * 0.3,
                  child: ListView.builder(
                    itemCount: provider.shoppingCart.length,
                    itemBuilder: (context, index) {
                      final product = provider.shoppingCart[index];
                      return ListTile(
                        leading: Image.network(
                          product.photoUrl ?? '',
                          width: width * 0.1,
                          height: width * 0.1,
                          fit: BoxFit.cover,
                        ),
                        title: AbelText(
                          text: product.name,
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
