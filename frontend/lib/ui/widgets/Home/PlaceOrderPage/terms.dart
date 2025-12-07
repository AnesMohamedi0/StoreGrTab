import 'package:flutter/material.dart';
import 'package:grtabstore/providers/HomeProviders/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/infoDialog.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class TermsCheck extends StatelessWidget {
  const TermsCheck({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Consumer<OrderProvider>(
          builder: (context, orderProvider, child) {
            return Checkbox(
              value: orderProvider.isAgreedToTerms,
              checkColor: Colors.white,
              activeColor: textPrimary,
              onChanged: (bool? value) {
                orderProvider.triggerAgreedToTerms();
              },
            );
          },
        ),
        AbelText(
          text: 'I agree to the ',
          fontSize: width * 0.035,
          color: textSecondary,
        ),
        Row(
          children: [
            AbelText(
              text: 'terms and conditions',
              fontSize: width * 0.035,
              color: textPrimary,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return InfoDialog(
                      title: 'Terms and Conditions',
                      description:
                          '1- We ONLY do testing warranty (10 days from the purchase date) \n'
                          '2- The delivery fee is determined by the province and the delivery type you choose.\n'
                          '3- We deliver with Zr Express, the stop desk option is for the nearest Zr Express pickup point.\n'
                          '4- The delivery time may vary based on your location and the delivery type selected. (24 to 48 hours).\n',
                    );
                  },
                );
              },
              icon: Icon(Icons.info, color: textTertiary, size: width * 0.04),
            ),
          ],
        ),
      ],
    );
  }
}
