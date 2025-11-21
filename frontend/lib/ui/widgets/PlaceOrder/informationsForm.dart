import 'package:flutter/material.dart';
import 'package:grtabstore/providers/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/PlaceOrder/communeSelector.dart';
import 'package:grtabstore/ui/widgets/PlaceOrder/deliveryType.dart';
import 'package:grtabstore/ui/widgets/PlaceOrder/provienceSelector.dart';
import 'package:grtabstore/ui/widgets/PlaceOrder/textForm.dart';
import 'package:provider/provider.dart';

class InformationsForm extends StatelessWidget {
  const InformationsForm({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextForm(
                controller: TextEditingController(),
                label: 'First Name',
                icon: Icon(
                  Icons.person,
                  color: textSecondary,
                  size: width * 0.05,
                ),
                onChange: (value) {
                  Provider.of<OrderProvider>(
                    context,
                    listen: false,
                  ).setName(value);
                },
              ),
            ),
            Expanded(
              child: TextForm(
                controller: TextEditingController(),
                label: 'Last Name',
                icon: Icon(
                  Icons.person,
                  color: textSecondary,
                  size: width * 0.05,
                ),
                onChange: (value) {
                  Provider.of<OrderProvider>(
                    context,
                    listen: false,
                  ).setLastName(value);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: width * 0.02),
        Row(
          children: [
            Expanded(
              child: TextForm(
                controller: TextEditingController(),
                label: 'Phone Number',
                icon: Icon(
                  Icons.phone,
                  color: textSecondary,
                  size: width * 0.05,
                ),
                onlyNumbers: true,
                onChange: (value) {
                  Provider.of<OrderProvider>(
                    context,
                    listen: false,
                  ).setPhoneNumber(value);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: width * 0.02),

        Row(
          children: [
            Expanded(child: ProvinceSelector()),
            Expanded(child: CommuneSelector()),
          ],
        ),
        SizedBox(height: width * 0.02),

        DeliveryTypeSelector(),
      ],
    );
  }
}
