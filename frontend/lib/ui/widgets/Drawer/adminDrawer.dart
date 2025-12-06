import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/logoDisplay.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class MobileCustomAdminDrawer extends StatelessWidget {
  const MobileCustomAdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: height * 0.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedFlexibleSpace(),
                      Column(
                        children: [
                          SizedBox(height: height * 0.02),
                          LogoDisplay(size: height * 0.1),
                          TitlesText(
                            text: 'Admin Panel',
                            fontSize: height * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),

          ListTile(
            leading: Icon(
              Icons.close,
              color: textSecondary,
              size: width * 0.06,
            ),
            title: AbelText(
              text: 'Close',
              fontSize: width * 0.048,
              color: textPrimary,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(height: height * 0.02),
        ],
      ),
    );
  }
}
