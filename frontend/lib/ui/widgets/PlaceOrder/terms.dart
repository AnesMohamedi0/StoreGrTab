import 'package:flutter/material.dart';
import 'package:grtabstore/providers/HomeProviders/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
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
          text: 'I agree to the terms and conditions',
          fontSize: width * 0.035,
        ),
      ],
    );
  }
}
