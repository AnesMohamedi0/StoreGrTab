import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/Filters/filterSortButton.dart';
import 'package:grtabstore/ui/widgets/Home/PlaceOrder.dart/informationsForm.dart';
import 'package:grtabstore/ui/widgets/Home/Product/ProductHorizontalDisplay.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class MobilePlaceOrder extends StatelessWidget {
  final List<(Product, int)> products;
  const MobilePlaceOrder({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryBackground,
      appBar: AppBar(
        toolbarHeight: height * 0.075,
        backgroundColor: electricBlueDarkest,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textOnDark, size: width * 0.07),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: EdgeInsets.only(top: height * 0.01),
          child: TitlesText(
            text: 'Placing Order',
            fontSize: width * 0.06,
            fontWeight: FontWeight.bold,
            color: textOnDark,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: width * 0.02),
                AbelText(
                  text:
                      "Please enter your personal informations to place the Order",
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.bold,
                  color: textSecondary,
                ),
              ],
            ),
            SizedBox(height: height * 0.02),

            InformationsForm(),

            SizedBox(height: height * 0.02),
            ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
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
                      text: '${getTotalPrice(products).toStringAsFixed(0)} DA',
                      fontSize: width * 0.042,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

double getTotalPrice(List<(Product, int)> products) {
  double total = 0;
  for (var item in products) {
    total += item.$1.price * item.$2;
  }
  return total;
}
