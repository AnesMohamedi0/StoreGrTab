import 'package:flutter/material.dart';
import 'package:grtabstore/providers/HomeProviders/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/PlaceOrderPage/communeSelector.dart';
import 'package:grtabstore/ui/widgets/Home/PlaceOrderPage/deliveryType.dart';
import 'package:grtabstore/ui/widgets/Home/PlaceOrderPage/provienceSelector.dart';
import 'package:grtabstore/ui/widgets/Shared/infoDialog.dart';
import 'package:grtabstore/ui/widgets/Shared/textForm.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
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
            Icon(Icons.person, color: textSecondary, size: width * 0.06),
            SizedBox(width: width * 0.01),
            AbelText(
              text: 'Personal Information:',
              fontSize: width * 0.038,
              color: textSecondary,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return InfoDialog(
                      title: 'Personal Information',
                      description:
                          'Please provide your personal information to proceed with the order.',
                    );
                  },
                );
              },
              icon: Icon(Icons.info, color: textTertiary, size: width * 0.04),
            ),
          ],
        ),
        SizedBox(height: width * 0.02),
        Row(
          children: [
            Expanded(
              child: TextForm(
                controller: TextEditingController()
                  ..text = Provider.of<OrderProvider>(
                    context,
                    listen: false,
                  ).name,
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
                controller: TextEditingController()
                  ..text = Provider.of<OrderProvider>(
                    context,
                    listen: false,
                  ).lastName,
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
                controller: TextEditingController()
                  ..text = Provider.of<OrderProvider>(
                    context,
                    listen: false,
                  ).phoneNumber,
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
