import 'package:flutter/material.dart';
import 'package:grtabstore/providers/AdminProvider/orderPanelProvider.dart';
import 'package:grtabstore/ui/screens/Admin/OrderPanel/mobileOrderPanelPage.dart';
import 'package:grtabstore/ui/screens/Admin/desktopAdminPage.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Admin/PanelButton.dart';
import 'package:grtabstore/ui/widgets/Drawer/adminDrawer.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Shared/menuButton.dart';
import 'package:grtabstore/ui/widgets/Shared/responsiveLayout.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class MobileAdminPage extends StatelessWidget {
  const MobileAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryBackground,
      drawer: MobileCustomAdminDrawer(),
      appBar: AppBar(
        toolbarHeight: height * 0.13,
        backgroundColor: Colors.transparent,
        elevation: 1,
        leading: MenuButton(),
        flexibleSpace: Stack(
          children: [
            // Full animated background
            Positioned(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: AnimatedFlexibleSpace(placeOrder: true),
              ),
            ),
            // Content overlay
            SafeArea(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.admin_panel_settings,
                      size: width * 0.1,
                      color: textOnBlue,
                    ),
                    TitlesText(
                      text: 'Admin Panel',
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: textOnDark,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.04,
        ),
        height: double.infinity,
        child: ListView(
          children: [
            PanelButton(
              icon: Icon(
                Icons.shopping_bag,
                color: textPrimary,
                size: width * 0.04,
              ),
              text: 'Orders Panel',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => OrderPanelProvider(),
                      child: MobileOrderPanelPage(),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: height * 0.02),

            PanelButton(
              icon: Icon(
                Icons.ad_units,
                color: textPrimary,
                size: width * 0.04,
              ),
              text: 'Advertisement Panel',
              onPressed: () {},
            ),
            SizedBox(height: height * 0.02),
            PanelButton(
              icon: Icon(
                Icons.branding_watermark,
                color: textPrimary,
                size: width * 0.04,
              ),
              text: 'Brand Panel',
              onPressed: () {},
            ),
            SizedBox(height: height * 0.02),
            PanelButton(
              icon: Icon(Icons.tablet, color: textPrimary, size: width * 0.04),
              text: 'Products Panel',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
