import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Admin/adsPanel.dart';
import 'package:grtabstore/ui/widgets/Drawer/adminDrawer.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Shared/menuButton.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

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
        child: ListView(children: [AdsPanel()]),
      ),
    );
  }
}
