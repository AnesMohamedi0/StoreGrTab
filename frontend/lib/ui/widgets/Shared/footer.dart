import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/socialMediaButton.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFooter.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class WebsiteFooter extends StatelessWidget {
  const WebsiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: height * 0.15,
      color: electricBlueDarkest,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedFooter(),
          Positioned(
            top: height * 0.015,
            child: TitlesText(
              text: 'Your satisfaction, Our commitment!',
              fontSize: width * 0.04,
              color: textOnBlue,
            ),
          ),

          Positioned(
            top: height * 0.07,
            child: Row(
              children: [
                Icon(
                  Icons.email_outlined,
                  color: textOnBlue,
                  size: width * 0.05,
                ),
                SizedBox(width: width * 0.01),
                AbelText(
                  text: 'Graphics.Tablet.Store@gmail.com',
                  fontSize: width * 0.045,
                  color: Colors.white,
                ),
              ],
            ),
          ),

          Positioned(
            top: height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMediaButton(
                  onPressed: () {},
                  icon: Icon(Icons.facebook, color: Colors.white),
                  label: "Facebook",
                ),

                SocialMediaButton(
                  onPressed: () {},
                  icon: Icon(Icons.facebook, color: Colors.white),
                  label: "Instagram",
                ),

                SocialMediaButton(
                  onPressed: () {},
                  icon: Icon(Icons.phone, color: Colors.white),
                  label: "Whatsapp",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
