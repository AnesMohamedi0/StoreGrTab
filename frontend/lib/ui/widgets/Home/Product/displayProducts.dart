import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/brand.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/providers/brandsProvider.dart';
import 'package:grtabstore/providers/cartProvider.dart';
import 'package:grtabstore/ui/screens/mobileProdcutPage.dart/mobileProductPage.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/Product/brandDisplay.dart';
import 'package:grtabstore/ui/widgets/Home/Product/newAlmost.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class ProductDisplay extends StatelessWidget {
  final Product product;
  final double width;
  final double height;
  const ProductDisplay({
    super.key,
    required this.product,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MobileProductPage(product: product),
          ),
        );
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            colors: [textOnBlue, cardBackgroundSecondary],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: height * 0.78,
                child: product.photoUrl.isNotEmpty
                    ? Image.network(product.photoUrl.first, fit: BoxFit.cover)
                    : Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.image, size: width * 0.2),
                      ),
              ),
            ),
            Positioned(
              left: width * 0.08,
              bottom: height * 0.21,
              child: AbelText(
                text: product.name,
                fontSize: width * 0.105,
                fontWeight: FontWeight.bold,
                color: textPrimary,
              ),
            ),

            Positioned(
              left: width * 0.08,
              bottom: height * 0.16,
              child: Row(
                children: [
                  Icon(
                    Icons.aspect_ratio,
                    color: textTertiary,
                    size: width * 0.07,
                  ),
                  SizedBox(width: width * 0.02),
                  AbelText(
                    text: '${product.actifAreaX}* ${product.actifAreaY}"',
                    fontSize: width * 0.08,
                    color: textTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),

            Positioned(
              left: width * 0.08,
              bottom: height * 0.08,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (product.oldPrice != null)
                    AbelText(
                      text: '${product.oldPrice!.toStringAsFixed(0)} DA',
                      fontSize: width * 0.085,
                      color: textTertiary,
                      fontWeight: FontWeight.w400,
                      lineThrough: true,
                    ),
                  if (product.oldPrice != null) SizedBox(width: width * 0.02),
                  AbelText(
                    text: '${product.price.toStringAsFixed(0)} DA',
                    fontSize: width * 0.0935,
                    color: textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),

            Positioned(
              top: height * 0.73,
              right: 0,
              child: !product.isNew
                  ? !product.isAlmostSoldOut
                        ? Container()
                        : NewAlmostSoldOut(
                            color: electricBlueDark,
                            width: width * 0.07,
                            text: ' Almost Sold Out ... ',
                          )
                  : NewAlmostSoldOut(
                      color: deepPurpleDark,
                      width: width * 0.07,
                      text: " NEW ! ",
                    ),
            ),

            // ...existing code...
            Positioned(
              right: width * 0.03,
              bottom: height * 0.02,
              child: Consumer<BrandsProvider>(
                builder: (context, brandsProvider, child) {
                  if (brandsProvider.isLoading) {
                    return Container(
                      width: width * 0.2,
                      height: width * 0.05,
                      color: Colors.grey.shade300,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: deepPurpleDarkest,
                      ),
                    );
                  }
                  final brand = brandsProvider.getBrandById(product.brandId);

                  // Show loading or placeholder while brand is not loaded
                  if (brand == null) {
                    return Container(
                      width: width * 0.2,
                      height: width * 0.05,
                      color: Colors.grey.shade300,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: deepPurpleDarkest,
                      ),
                    );
                  }

                  return BrandDisplay(brand: brand, width: width);
                },
              ),
            ),
            // ...existing code...
            Positioned(
              right: width * 0.03,
              top: height * 0.035,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Provider.of<CartProvider>(
                      context,
                      listen: false,
                    ).addProduct(product);
                  },
                  icon: Icon(
                    Icons.add_shopping_cart_rounded,
                    color: deepPurpleDarkest,
                    size: width * 0.15,
                  ),
                ),
              ),
            ),

            Consumer<CartProvider>(
              builder: (context, provider, _) {
                if (!provider.isInCart(product)) {
                  return Container();
                }

                return Positioned(
                  right: width * 0,
                  top: height * 0.005,
                  child: Container(
                    width: provider.getProductQuantity(product) <= 9
                        ? width * 0.07
                        : width * 0.1,
                    height: width * 0.065,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: deepPurpleDark,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: AbelText(
                      text: provider.getProductQuantity(product).toString(),
                      color: textOnBlue,
                      fontSize: width * 0.05,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
