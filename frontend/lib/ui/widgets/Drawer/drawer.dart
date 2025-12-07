import 'package:flutter/material.dart';
import 'package:grtabstore/providers/AdminProvider/adminAdsProvider.dart';
import 'package:grtabstore/providers/AdminProvider/orderPanelProvider.dart';
import 'package:grtabstore/providers/authProvider.dart';
import 'package:grtabstore/ui/screens/Admin/desktopAdminPage.dart';
import 'package:grtabstore/ui/screens/Admin/mobileAdminPage.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/Cart/cartModal.dart';
import 'package:grtabstore/ui/widgets/Shared/logoDisplay.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Shared/loginModal.dart';
import 'package:grtabstore/ui/widgets/Shared/responsiveLayout.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

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
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return ListTile(
                leading: Icon(
                  authProvider.isAuthenticated
                      ? Icons.admin_panel_settings
                      : Icons.login,
                  color: textSecondary,
                  size: width * 0.06,
                ),
                title: AbelText(
                  text: authProvider.isAuthenticated ? 'Admin Panel' : 'Login',
                  fontSize: width * 0.048,
                  color: textPrimary,
                ),
                onTap: () async {
                  if (authProvider.isAuthenticated) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (_) => OrderPanelProvider(),
                            ),
                            ChangeNotifierProvider(
                              create: (_) => AdminAdsProvider(),
                            ),
                          ],
                          child: ResponsiveLayout(
                            mobile: MobileAdminPage(),
                            desktop: DesktopAdminPage(),
                          ),
                        ),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                    await Future.delayed(Duration(milliseconds: 200));
                    showLoginModal(context);
                  }
                },
              );
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
