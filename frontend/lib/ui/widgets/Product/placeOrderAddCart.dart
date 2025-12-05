import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/providers/cartProvider.dart';
import 'package:grtabstore/providers/orderProvider.dart';
import 'package:grtabstore/ui/screens/Home/desktopHome_screen.dart';
import 'package:grtabstore/ui/screens/PlaceOrder/mobilePlaceOrder.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/Cart/cartModal.dart';
import 'package:grtabstore/ui/widgets/Home/Filters/filterSortButton.dart';
import 'package:grtabstore/ui/widgets/PlaceOrder/placeOrderButton.dart';
import 'package:grtabstore/ui/widgets/Shared/responsiveLayout.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class PlaceOrderAddCart extends StatelessWidget {
  final Product product;
  const PlaceOrderAddCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Row(
        children: [
          Consumer<CartProvider>(
            builder: (context, provider, _) {
              int quantity = provider.getProductQuantity(product);
              if (quantity > 0) {
                return TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      builder: (context) {
                        return FractionallySizedBox(child: const CartModal());
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          width * 0.15 * 0.1, // Match FilterSortButton padding
                      vertical:
                          width * 0.15 * 0.05, // Match FilterSortButton padding
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: textOnDark, // Keep inverted style
                      border: Border.all(color: textPrimary, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons
                              .shopping_cart_checkout_outlined, // Change to check icon to show it's added
                          color: textPrimary,
                          size: width * 0.05,
                        ),
                        SizedBox(
                          width: width * 0.15 * 0.1,
                        ), // Match FilterSortButton spacing
                        AbelText(
                          // Use AbelText to match other buttons
                          text: 'In Cart',
                          fontSize:
                              width *
                              0.15 *
                              0.3, // Match FilterSortButton font size
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return FilterSortButton(
                  label: 'Add to Cart',
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: textPrimary,
                    size: width * 0.05,
                  ),
                  function: () {
                    Provider.of<CartProvider>(
                      context,
                      listen: false,
                    ).addProduct(product);
                  },
                  size: width * 0.15,
                  inverted: true,
                  border: true,
                );
              }
            },
          ),

          SizedBox(width: width * 0.02),

          FilterSortButton(
            label: 'Place Order',
            icon: Icon(
              Icons.shopping_bag,
              color: textOnDark,
              size: width * 0.05,
            ),
            function: () {
              List<(Product, int)> products = <(Product, int)>[(product, 1)];
              Provider.of<OrderProvider>(context, listen: false).setProducts =
                  products;
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
            inverted: false,
            border: true,
          ),
        ],
      ),
    );
  }
}
