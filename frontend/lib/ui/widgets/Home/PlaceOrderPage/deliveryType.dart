import 'package:flutter/material.dart';
import 'package:grtabstore/providers/HomeProviders/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/infoDialog.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class DeliveryTypeSelector extends StatelessWidget {
  const DeliveryTypeSelector({super.key});

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
                    Icons.delivery_dining,
                    color: textSecondary,
                    size: width * 0.06,
                  ),
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Delivery Type:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),

                  if (orderProvider.province?.name == 'ALGER')
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return InfoDialog(
                              title: 'Public Pickup',
                              description:
                                  'Public pickup is free and only available on :\n'
                                  '1- Ouled Belhaj, Saoula, Alger. \n'
                                  '2- USTHB, Bab Ezzouar, Alger.',
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.info,
                        color: textTertiary,
                        size: width * 0.04,
                      ),
                    ),
                ],
              ),
              SizedBox(height: width * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        orderProvider.setDeliveryType(0);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: width * 0.005,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: textPrimary, width: 1.5),
                          color: orderProvider.deliveryType == 0
                              ? textPrimary
                              : Colors.transparent,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.store_mall_directory_sharp,
                              color: orderProvider.deliveryType == 0
                                  ? textOnDark
                                  : textPrimary,
                              size: width * 0.04,
                            ),
                            SizedBox(width: width * 0.01),
                            AbelText(
                              text: 'Desk Pickup',
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold,
                              color: orderProvider.deliveryType == 0
                                  ? textOnDark
                                  : textPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.015),
                  Flexible(
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        orderProvider.setDeliveryType(1);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: width * 0.005,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: textPrimary, width: 1.5),
                          color: orderProvider.deliveryType == 1
                              ? textPrimary
                              : Colors.transparent,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.home,
                              color: orderProvider.deliveryType == 1
                                  ? textOnDark
                                  : textPrimary,
                              size: width * 0.04,
                            ),
                            SizedBox(width: width * 0.01),
                            AbelText(
                              text: 'A Domicile',
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold,
                              color: orderProvider.deliveryType == 1
                                  ? textOnDark
                                  : textPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.015),
                  if (orderProvider.province?.name == 'ALGER')
                    Flexible(
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          orderProvider.setDeliveryType(2);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: width * 0.005,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: textPrimary, width: 1.5),
                            color: orderProvider.deliveryType == 2
                                ? textPrimary
                                : Colors.transparent,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.public,
                                color: orderProvider.deliveryType == 2
                                    ? textOnDark
                                    : textPrimary,
                                size: width * 0.04,
                              ),
                              SizedBox(width: width * 0.01),
                              AbelText(
                                text: 'Public Pickup',
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold,
                                color: orderProvider.deliveryType == 2
                                    ? textOnDark
                                    : textPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
