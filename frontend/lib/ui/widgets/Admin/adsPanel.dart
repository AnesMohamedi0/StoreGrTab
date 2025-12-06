import 'package:flutter/material.dart';
import 'package:grtabstore/providers/AdminProvider/adminAdsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class AdsPanel extends StatelessWidget {
  const AdsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<AdminAdsProvider>(
      builder: (context, adminAdsProvider, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.ad_units_rounded,
                      color: textSecondary,
                      size: width * 0.05,
                    ),
                    SizedBox(width: width * 0.01),
                    AbelText(
                      text: 'Advertisement Panel:',
                      fontSize: width * 0.045,
                      color: textPrimary,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    adminAdsProvider.toggleAdsPanel();
                  },
                  icon: Icon(
                    !adminAdsProvider.isOpened
                        ? Icons.expand_more
                        : Icons.expand_less,
                    color: textPrimary,
                    size: width * 0.06,
                  ),
                ),
              ],
            ),
            if (adminAdsProvider.isOpened) ...[Text('it is opened')],
          ],
        );
      },
    );
  }
}
