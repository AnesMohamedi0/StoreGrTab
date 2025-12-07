import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/order.dart';
import 'package:grtabstore/providers/HomeProviders/cartProvider.dart';
import 'package:grtabstore/providers/HomeProviders/orderProvider.dart';
import 'package:grtabstore/services/apiService.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class PlaceOrderButton extends StatelessWidget {
  const PlaceOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.02),
          alignment: Alignment.centerLeft,
          child: TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: !orderProvider.canOrder()
                ? null
                : () async {
                    List<(int, int)> products = orderProvider.products
                        .map((e) => (e.$1.productId, e.$2))
                        .toList();

                    Order order = Order(
                      orderId: 0,
                      products: products,
                      name: orderProvider.name,
                      lastName: orderProvider.lastName,
                      phone: orderProvider.phoneNumber,
                      communeId: orderProvider.commune!.id,
                      deliveryType: orderProvider.deliveryType,
                      totalPrice: orderProvider.getTotalOrderCost(),
                      orderDate: DateTime.now(),
                    );

                    await apiService.post('Order', order.toJson());

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: AbelText(
                          text: 'Order placed successfully!',
                          fontSize: width * 0.04,
                          color: textOnDark,
                        ),
                        backgroundColor: accentSuccess,
                      ),
                    );

                    context.read<CartProvider>().clearCart();

                    Navigator.pop(context);
                  },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: width * 0.005,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: textPrimary, width: 1.5),
                color: orderProvider.canOrder()
                    ? textPrimary
                    : Colors.transparent,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_checkout,
                    color: orderProvider.canOrder() ? textOnDark : textPrimary,
                    size: width * 0.05,
                  ),
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Place Order',
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: orderProvider.canOrder() ? textOnDark : textPrimary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
