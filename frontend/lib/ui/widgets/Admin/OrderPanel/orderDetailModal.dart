import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/commune.dart';
import 'package:grtabstore/data/models/order.dart';
import 'package:grtabstore/data/models/province.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class OrderDetailModal extends StatelessWidget {
  final List<(String, int)> products;
  final Commune commune;
  final Province province;
  final Order order;
  const OrderDetailModal({
    super.key,
    required this.order,
    required this.products,
    required this.commune,
    required this.province,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,

      child: Container(
        padding: EdgeInsets.all(width * 0.02),
        width: width * 0.8,
        height: height * 0.7,
        decoration: BoxDecoration(
          color: primaryBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: textPrimary,
                        size: width * 0.06,
                      ),
                      SizedBox(width: width * 0.02),
                      AbelText(
                        text:
                            '${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                        fontSize: width * 0.055,
                      ),
                      SizedBox(width: width * 0.015),

                      AbelText(
                        text:
                            '${order.orderDate.hour}H${order.orderDate.minute}',
                        color: textSecondary,
                        fontSize: width * 0.047,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: textPrimary,
                    size: width * 0.06,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Divider(color: textSecondary),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, color: textPrimary, size: width * 0.06),
                    SizedBox(width: width * 0.02),
                    AbelText(
                      text: '${order.name} ${order.lastName}',
                      fontSize: width * 0.055,
                    ),
                  ],
                ),
                AbelText(
                  text: order.phone,
                  fontSize: width * 0.04,
                  color: textSecondary,
                ),
              ],
            ),
            Divider(color: textSecondary),

            Row(
              children: [
                Icon(
                  Icons.shopping_bag,
                  color: textPrimary,
                  size: width * 0.05,
                ),
                SizedBox(width: width * 0.02),
                AbelText(text: 'Products :', fontSize: width * 0.05),
              ],
            ),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final (productName, quantity) = products[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AbelText(text: productName, fontSize: width * 0.04),
                      AbelText(
                        text: 'x$quantity',
                        fontSize: width * 0.04,
                        color: textSecondary,
                      ),
                    ],
                  );
                },
              ),
            ),

            Divider(color: textSecondary),

            Row(
              children: [
                Icon(Icons.location_on, color: textPrimary, size: width * 0.05),
                SizedBox(width: width * 0.02),
                AbelText(text: 'Location :', fontSize: width * 0.05),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AbelText(
                        text: 'Commune: ',
                        fontSize: width * 0.04,
                        color: textSecondary,
                      ),
                      SizedBox(width: width * 0.02),
                      AbelText(text: commune.name, fontSize: width * 0.04),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AbelText(
                        text: 'Provience: ',
                        fontSize: width * 0.04,
                        color: textSecondary,
                      ),
                      SizedBox(width: width * 0.02),
                      AbelText(text: province.name, fontSize: width * 0.04),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: textSecondary),
            Row(
              children: [
                Icon(
                  Icons.delivery_dining,
                  color: textPrimary,
                  size: width * 0.05,
                ),
                SizedBox(width: width * 0.02),
                AbelText(text: 'Delivery Type:', fontSize: width * 0.05),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AbelText(
                    text: order.deliveryType == 0
                        ? 'Desk Pickup'
                        : order.deliveryType == 1
                        ? 'Home Delivery'
                        : 'Public Pickup',
                    fontSize: width * 0.045,
                  ),
                ],
              ),
            ),
            Divider(color: textSecondary),
            Row(
              children: [
                Icon(
                  Icons.monetization_on,
                  color: textPrimary,
                  size: width * 0.05,
                ),
                SizedBox(width: width * 0.02),
                AbelText(text: 'Total Price :', fontSize: width * 0.05),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AbelText(
                    text: '${order.totalPrice.toStringAsFixed(0)} DA',
                    fontSize: width * 0.045,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Static method to show the modal
  static void show(
    BuildContext context,
    Order order,
    List<(String, int)> products,
    Commune commune,
    Province province,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => OrderDetailModal(
        order: order,
        products: products,
        commune: commune,
        province: province,
      ),
    );
  }
}
