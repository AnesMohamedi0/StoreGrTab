import 'package:flutter/material.dart';
import 'package:grtabstore/providers/HomeProviders/cartProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Home/Cart/cartModal.dart';
import 'package:grtabstore/ui/widgets/Shared/logoDisplay.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class CustomFlexibleSpaceContent extends StatelessWidget {
  final double collapseRatio;

  const CustomFlexibleSpaceContent({super.key, required this.collapseRatio});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Opacity(
              opacity: collapseRatio.clamp(0.0, 1.0),
              child: AnimatedFlexibleSpace(),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: collapseRatio <= 0.1 ? height * 0.02 : null,
            bottom: collapseRatio > 0.1 ? height * 0.0 : null,
            child: Container(
              alignment: collapseRatio <= 0.1
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              padding: EdgeInsets.only(
                top: height * 0.02 * collapseRatio,
                bottom: height * 0.0 * collapseRatio,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo above text (only visible when expanded)
                  if (collapseRatio > 0.1)
                    Opacity(
                      opacity: collapseRatio.clamp(0.0, 1.0),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: height * 0.01 * collapseRatio,
                        ),
                        child: LogoDisplay(
                          size: width * 0.25 * collapseRatio + width * 0.1,
                        ),
                      ),
                    ),

                  // The main title — always visible, positioned based on collapse
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.01 * collapseRatio,
                    ),
                    child: TitlesText(
                      text: "Graphics Tablet Store",
                      fontSize: width * 0.06,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Subtitle below text (only visible when expanded)
                  if (collapseRatio > 0.1)
                    Opacity(
                      opacity: collapseRatio.clamp(0.0, 0.7),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: height * 0.02 * collapseRatio,
                        ),
                        child: TitlesText(
                          text:
                              'Discover the Best Graphics Tablets at Unbeatable Prices!',
                          fontSize: width * 0.035,
                          color: textOnBlue,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
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
      ),
    );
  }
}
