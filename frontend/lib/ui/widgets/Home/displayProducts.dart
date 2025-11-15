import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/brand.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/providers/brandsProvider.dart';
import 'package:grtabstore/providers/cartProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/brandDisplay.dart';
import 'package:grtabstore/ui/widgets/Home/newAlmost.dart';
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
    return Container(
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
              child: Image.network(product.photoUrl ?? '', fit: BoxFit.cover),
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
            child: AbelText(
              text: '${product.actifAreaX}* ${product.actifAreaY}"',
              fontSize: width * 0.08,
              color: textSecondary,
              fontWeight: FontWeight.w600,
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
                  color: textPrice,
                  fontWeight: FontWeight.w600,
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
                          color: accentWarning,
                          width: width * 0.07,
                          text: ' Almost Sold Out ... ',
                        )
                : NewAlmostSoldOut(
                    color: accentSuccess,
                    width: width * 0.07,
                    text: " NEW ! ",
                  ),
          ),

          Positioned(
            right: width * 0.03,
            bottom: height * 0.02,
            child: BrandDisplay(
              brand:
                  Provider.of<BrandsProvider>(
                    context,
                    listen: false,
                  ).getBrandById(product.brandId) ??
                  Brand(brandId: 0, name: ''),
              width: width,
              color: textOnDark,
            ),
          ),
          Positioned(
            right: width * 0,
            top: height * 0,
            child: IconButton(
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

          Consumer<CartProvider>(
            builder: (context, provider, _) {
              if (!provider.isInCart(product)) {
                return Container();
              }

              return Positioned(
                right: width * 0,
                top: height * 0,
                child: Container(
                  width: provider.getProductQuantity(product) <= 9
                      ? width * 0.07
                      : width * 0.1,
                  height: width * 0.065,
                  color: deepPurpleDark,
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
    );
  }
}
