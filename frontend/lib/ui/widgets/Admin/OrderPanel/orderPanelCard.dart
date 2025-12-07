import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/order.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/providers/AdminProvider/orderPanelProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Admin/OrderPanel/orderDetailModal.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class OrderPanelCard extends StatelessWidget {
  final Order order;
  const OrderPanelCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () async {
        // Show loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(electricBlue),
                  ),
                  SizedBox(height: 16),
                  AbelText(
                    text: 'Loading order details...',
                    fontSize: width * 0.035,
                    color: textPrimary,
                  ),
                ],
              ),
            ),
          ),
        );

        try {
          final products = await Provider.of<OrderPanelProvider>(
            context,
            listen: false,
          ).getOrderProductsString(order.orderId);
          final commune = await Provider.of<OrderPanelProvider>(
            context,
            listen: false,
          ).getOrderCommune(order.orderId);
          final province = await Provider.of<OrderPanelProvider>(
            context,
            listen: false,
          ).getOrderProvince(commune!);

          // Hide loading dialog
          Navigator.pop(context);

          if (commune == null || province == null) return;
          OrderDetailModal.show(context, order, products, commune, province);
        } catch (e) {
          // Hide loading dialog
          Navigator.pop(context);

          // Show error dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: primaryBackground,
              title: AbelText(
                text: 'Error',
                fontSize: width * 0.045,
                color: textPrimary,
              ),
              content: AbelText(
                text: 'Failed to load order details. Please try again.',
                fontSize: width * 0.035,
                color: textSecondary,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: AbelText(
                    text: 'OK',
                    fontSize: width * 0.035,
                    color: electricBlue,
                  ),
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.005),
        padding: EdgeInsets.symmetric(
          vertical: width * 0.02,
          horizontal: width * 0.04,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [secondaryBackground, primaryBackground],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: textSecondary, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: textPrimary,
                  size: width * 0.05,
                ),
                SizedBox(width: width * 0.01),
                AbelText(
                  text:
                      '${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                  fontSize: width * 0.035,
                ),
              ],
            ),
            SizedBox(width: width * 0.03),

            Row(
              children: [
                AbelText(
                  text: '${order.totalPrice.toStringAsFixed(0)} DA',
                  fontSize: width * 0.035,
                  color: textSecondary,
                ),
              ],
            ),

            SizedBox(width: width * 0.03),
            Row(
              children: [
                Icon(Icons.person, color: textPrimary, size: width * 0.05),
                SizedBox(width: width * 0.01),
                AbelText(
                  text: '${order.name} ${order.lastName}',
                  fontSize: width * 0.035,
                ),
              ],
            ),

            Expanded(child: Container()),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Provider.of<OrderPanelProvider>(
                  context,
                  listen: false,
                ).deleteOrder(order.orderId);
              },
              icon: Icon(Icons.delete, color: accentError, size: width * 0.06),
            ),
          ],
        ),
      ),
    );
  }
}
