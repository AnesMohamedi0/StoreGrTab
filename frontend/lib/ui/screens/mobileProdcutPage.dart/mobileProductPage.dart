import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Product/itemDescription.dart';
import 'package:grtabstore/ui/widgets/Product/imagesDisplay.dart';
import 'package:grtabstore/ui/widgets/Product/placeOrderAddCart.dart';
import 'package:grtabstore/ui/widgets/Product/priceDisplay.dart';
import 'package:grtabstore/ui/widgets/Product/productNameDisplay.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Shared/footer.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class MobileProductPage extends StatelessWidget {
  final Product product;
  const MobileProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryBackground,
      appBar: AppBar(
        toolbarHeight: height * 0.075,
        backgroundColor: Colors.transparent,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.home, color: textOnDark, size: width * 0.07),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        flexibleSpace: Stack(
          alignment: Alignment.center,
          children: [
            // Full animated background
            AnimatedFlexibleSpace(placeOrder: true, raduis: 5),
            TitlesText(
              text: 'Product Details',
              fontSize: width * 0.06,
              fontWeight: FontWeight.bold,
              color: textOnDark,
            ),
          ],
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: ListView(
            children: [
              // Add error boundary for images
              Builder(
                builder: (context) {
                  try {
                    return ImagesDisplay(imagesUrl: product.photoUrl);
                  } catch (e) {
                    print('Error loading product images: $e');
                    return Container(
                      height: width * 0.7,
                      decoration: BoxDecoration(
                        color: cardBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: width * 0.1,
                              color: textSecondary,
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              'Image not available',
                              style: TextStyle(color: textSecondary),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                child: Column(
                  children: [
                    ProductNameDisplay(product: product),
                    ItemDescription(product: product),
                    SizedBox(height: height * 0.01),
                    PriceDisplay(product: product),
                    SizedBox(height: height * 0.02),
                    PlaceOrderAddCart(product: product),
                    SizedBox(height: height * 0.06),
                  ],
                ),
              ),
              WebsiteFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
