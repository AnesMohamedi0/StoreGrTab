import 'package:flutter/material.dart';
import 'package:grtabstore/providers/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class TotalPriceDisplay extends StatelessWidget {
  const TotalPriceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      child: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: textSecondary,
                    size: width * 0.06,
                  ),
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Cost Summary:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),

                  if (orderProvider.province.name == 'Alger')
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // Handle icon button press
                      },
                      icon: Icon(
                        Icons.info,
                        color: textTertiary,
                        size: width * 0.04,
                      ),
                    ),
                ],
              ),
              SizedBox(height: width * 0.005),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AbelText(
                          text: 'Items Cost:',
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: textSecondary,
                        ),
                        SizedBox(width: width * 0.02),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AbelText(
                              text: orderProvider
                                  .getTotalItemCost()
                                  .toStringAsFixed(0),
                              fontSize: width * 0.042,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                            SizedBox(width: width * 0.01),
                            AbelText(
                              text: 'DA',
                              fontSize: width * 0.037,
                              fontWeight: FontWeight.bold,
                              color: textSecondary,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AbelText(
                          text: 'Delivery Cost:',
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: textSecondary,
                        ),
                        SizedBox(width: width * 0.02),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AbelText(
                              text: orderProvider
                                  .getDeliveryCost()
                                  .toStringAsFixed(0),
                              fontSize: width * 0.042,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                            SizedBox(width: width * 0.01),
                            AbelText(
                              text: 'DA',
                              fontSize: width * 0.037,
                              fontWeight: FontWeight.bold,
                              color: textSecondary,
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AbelText(
                          text: 'Total:',
                          fontSize: width * 0.043,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                        SizedBox(width: width * 0.02),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AbelText(
                              text: orderProvider
                                  .getTotalOrderCost()
                                  .toStringAsFixed(0),
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                            SizedBox(width: width * 0.01),
                            AbelText(
                              text: 'DA',
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: textSecondary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
