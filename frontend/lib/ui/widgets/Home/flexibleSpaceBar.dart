import 'package:flutter/material.dart';
import 'package:grtabstore/ui/widgets/Home/animatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Home/logoDisplay.dart';
import 'package:grtabstore/ui/widgets/Home/socialMediaButton.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialMediaButton(
                              onPressed: () {},
                              icon: Icon(Icons.facebook, color: Colors.white),
                              label: "Follow Us",
                            ),

                            SocialMediaButton(
                              onPressed: () {},
                              icon: Icon(Icons.email, color: Colors.white),
                              label: "Contact Us",
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
