import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/province.dart';
import 'package:grtabstore/providers/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:provider/provider.dart';

class ProvinceSelector extends StatelessWidget {
  const ProvinceSelector({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.015),
          padding: EdgeInsets.only(
            right: width * 0.02,
            top: height * 0.007,
            bottom: height * 0.005,
            left: width * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: textPrimary, width: 1.5),
          ),
          height: height * 0.045,
          child: Row(
            children: [
              Icon(Icons.location_on, color: textSecondary, size: width * 0.05),
              SizedBox(width: width * 0.02),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Province>(
                    // Current selected value
                    value: orderProvider.province,

                    // Hint text when nothing is selected
                    hint: Text(
                      "Select Province",
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: width * 0.035,
                      ),
                    ),

                    // Make dropdown take full width
                    isExpanded: true,

                    // Icon for dropdown
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: textSecondary,
                      size: width * 0.05,
                    ),

                    // Style for selected item
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: width * 0.035,
                    ),

                    // Dropdown items
                    items: orderProvider.provinces.map((Province province) {
                      return DropdownMenuItem<Province>(
                        value: province,
                        child: Text(
                          province.name,
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: width * 0.035,
                          ),
                        ),
                      );
                    }).toList(),

                    // When user selects an item
                    onChanged: (Province? selectedProvince) {
                      if (selectedProvince != null) {
                        orderProvider.setProvince(selectedProvince);
                        orderProvider.getAllCommunesForProvince(
                          selectedProvince,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
