import 'package:flutter/material.dart';
import 'package:grtabstore/providers/HomeProviders/cartProvider.dart';
import 'package:grtabstore/providers/HomeProviders/orderProvider.dart';
import 'package:grtabstore/ui/screens/Home/desktopHome_screen.dart';
import 'package:grtabstore/ui/screens/Home/PlaceOrder/mobilePlaceOrder.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/ProductDisplay/ProductHorizontalDisplay.dart';
import 'package:grtabstore/ui/widgets/Home/Filters/filterSortButton.dart';
import 'package:grtabstore/ui/widgets/Shared/responsiveLayout.dart';
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
      child: Consumer<CartProvider>(
        builder: (context, provider, _) {
          if (provider.products.isEmpty) {
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
                ListView.builder(
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
                    );
                  },
                ),

                SizedBox(height: height * 0.035),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AbelText(
                          text: 'Total Price:',
                          fontSize: width * 0.042,
                          fontWeight: FontWeight.bold,
                          color: textSecondary,
                        ),
                        SizedBox(width: width * 0.03),
                        AbelText(
                          text:
                              '${provider.getTotalPrice().toStringAsFixed(0)} DA',
                          fontSize: width * 0.042,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                      ],
                    ),

                    FilterSortButton(
                      label: 'Place Order',
                      icon: Icon(
                        Icons.shopping_bag_rounded,
                        color: textOnDark,
                        size: width * 0.05,
                      ),
                      function: () {
                        Provider.of<OrderProvider>(
                          context,
                          listen: false,
                        ).setProducts = provider.products;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResponsiveLayout(
                              mobile: MobilePlaceOrder(),
                              desktop: DesktopHomeScreen(),
                            ),
                          ),
                        ).then((_) {
                          Navigator.pop(context);
                        });
                      },
                      size: width * 0.15,
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
