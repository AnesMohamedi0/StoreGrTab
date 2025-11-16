import 'package:flutter/material.dart';
import 'package:grtabstore/providers/productsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/Product/newAlmost.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class StatueFilter extends StatelessWidget {
  const StatueFilter({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        AbelText(text: "Status :", fontSize: width * 0.05),
        Expanded(
          child: Consumer<ProductsProvider>(
            builder: (context, provider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: width * 0.05),
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      if (provider.statueFilter == 1) {
                        provider.removeStatueFilter();
                      } else {
                        provider.triggerFilterByNew();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06,
                        vertical: width * 0.01,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: (provider.statueFilter == 0)
                            ? textPrimary
                            : provider.statueFilter != 1
                            ? textSecondary
                            : textPrimary,
                      ),
                      child: AbelText(
                        text: 'NEW',
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: textOnDark,
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.05),

                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      if (provider.statueFilter == 2) {
                        provider.removeStatueFilter();
                      } else {
                        provider.triggerFilterByAlmostSoldOut();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06,
                        vertical: width * 0.01,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: (provider.statueFilter == 0)
                            ? textPrimary
                            : provider.statueFilter != 2
                            ? textSecondary
                            : textPrimary,
                      ),
                      child: AbelText(
                        text: 'ALMOST SOLD OUT',
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: textOnDark,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
