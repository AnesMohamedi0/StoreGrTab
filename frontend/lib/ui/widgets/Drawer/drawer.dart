import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/Cart/cartModal.dart';
import 'package:grtabstore/ui/widgets/Home/logoDisplay.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Shared/loginModal.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class MobileCustomDrawer extends StatelessWidget {
  const MobileCustomDrawer({super.key});

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
                            text: 'Graphics Tab Store',
                            fontSize: height * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: textSecondary,
                    size: width * 0.06,
                  ),
                  title: AbelText(
                    text: 'Home',
                    fontSize: width * 0.048,
                    color: textPrimary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: textSecondary,
                    size: width * 0.06,
                  ),
                  title: AbelText(
                    text: 'Cart',
                    fontSize: width * 0.048,
                    color: textPrimary,
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await Future.delayed(Duration(milliseconds: 200));

                    // Then show modal
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => CartModal(),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: textSecondary,
              size: width * 0.06,
            ),
            title: AbelText(
              text: 'Connection',
              fontSize: width * 0.048,
              color: textPrimary,
            ),
            onTap: () async {
              Navigator.pop(context);
              await Future.delayed(Duration(milliseconds: 200));
              showLoginModal(context);
            },
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
