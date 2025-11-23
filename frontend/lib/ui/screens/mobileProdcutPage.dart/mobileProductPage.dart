import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/providers/cartProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/Cart/cartModal.dart';
import 'package:grtabstore/ui/widgets/Home/logoDisplay.dart';
import 'package:grtabstore/ui/widgets/Product/itemDescription.dart';
import 'package:grtabstore/ui/widgets/Product/imagesDisplay.dart';
import 'package:grtabstore/ui/widgets/Product/placeOrderAddCart.dart';
import 'package:grtabstore/ui/widgets/Product/priceDisplay.dart';
import 'package:grtabstore/ui/widgets/Product/productNameDisplay.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Shared/footer.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class MobileProductPage extends StatelessWidget {
  Product product;
  MobileProductPage({super.key, required this.product});

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
        actions: [
          Consumer<CartProvider>(
            builder: (context, provider, _) {
              return Positioned(
                top: height * 0.01,
                right: 0,
                child: TextButton(
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
                  child: SizedBox(
                    width: width * 0.1,
                    height: height * 0.06,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_rounded,
                          color: Colors.white,
                          size: width * 0.08,
                        ),
                        Positioned(
                          top: -width * 0.02,
                          left: width * 0.04,
                          right: width * 0.01,
                          child: Container(
                            width: provider.getTotalItems() <= 9
                                ? width * 0.04
                                : width * 0.06,
                            height: width * 0.065,
                            color: deepPurpleDark,
                            alignment: Alignment.bottomCenter,
                            child: AbelText(
                              text: provider.getTotalItems().toString(),
                              color: textOnBlue,
                              fontSize: width * 0.04,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
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

      body: Container(
        height: double.infinity,
        child: ListView(
          children: [
            SizedBox(height: height * 0.02),
            ProductNameDisplay(product: product),
            ImagesDisplay(imagesUrl: product.photoUrl),
            SizedBox(height: height * 0.02),

            ItemDescription(product: product),
            SizedBox(height: height * 0.01),
            PriceDisplay(product: product),
            SizedBox(height: height * 0.02),
            PlaceOrderAddCart(product: product),
            SizedBox(height: height * 0.03),

            WebsiteFooter(),
          ],
        ),
      ),
    );
  }
}
