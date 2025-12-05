import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grtabstore/ui/theme/colors.dart';

class MobileAdminPage extends StatelessWidget {
  const MobileAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryBackground,
      appBar: AppBar(
        backgroundColor: electricBlue,
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.abel(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: width * 0.045,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.admin_panel_settings,
              size: width * 0.2,
              color: electricBlue,
            ),
            SizedBox(height: height * 0.03),
            Text(
              "I'm on Admin",
              style: GoogleFonts.abel(
                fontSize: width * 0.08,
                color: textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Welcome to the Admin Dashboard",
              style: GoogleFonts.abel(
                fontSize: width * 0.04,
                color: textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: height * 0.05),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.1),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.015,
              ),
              decoration: BoxDecoration(
                color: electricBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: electricBlue, width: 1),
              ),
              child: Text(
                "You have successfully accessed the admin panel. Here you can manage your store's data and settings.",
                textAlign: TextAlign.center,
                style: GoogleFonts.abel(
                  fontSize: width * 0.035,
                  color: textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}