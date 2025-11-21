import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/providers/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/Filters/filterSortButton.dart';
import 'package:grtabstore/ui/widgets/PlaceOrder/informationsForm.dart';
import 'package:grtabstore/ui/widgets/Home/Product/ProductHorizontalDisplay.dart';
import 'package:grtabstore/ui/widgets/PlaceOrder/placeOrderButton.dart';
import 'package:grtabstore/ui/widgets/PlaceOrder/priceDisplay.dart';
import 'package:grtabstore/ui/widgets/PlaceOrder/productsToOrder.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Home/logoDisplay.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class MobilePlaceOrder extends StatelessWidget {
  const MobilePlaceOrder({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryBackground,
      appBar: AppBar(
        toolbarHeight: height * 0.175,
        backgroundColor: Colors.transparent,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.home, color: textOnDark, size: width * 0.07),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Stack(
          children: [
            // Full animated background
            Positioned(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: AnimatedFlexibleSpace(placeOrder: true),
              ),
            ),
            // Content overlay
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoDisplay(size: width * 0.15, padding: false),
                    SizedBox(height: height * 0.008),
                    TitlesText(
                      text: 'Placing Order',
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: textOnDark,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(width * 0.03),
        height: double.infinity,
        child: ListView(
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

            ProductsToOrder(),

            SizedBox(height: height * 0.02),

            InformationsForm(),

            SizedBox(height: height * 0.02),

            TotalPriceDisplay(),

            SizedBox(height: height * 0.02),

            PlaceOrderButton(),

            SizedBox(height: height * 0.04),
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
