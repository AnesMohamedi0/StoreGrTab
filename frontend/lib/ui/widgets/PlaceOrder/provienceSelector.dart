import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grtabstore/data/models/province.dart';
import 'package:grtabstore/providers/locationProvider.dart';
import 'package:grtabstore/providers/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:provider/provider.dart';

class ProvinceSelector extends StatelessWidget {
  const ProvinceSelector({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Consumer2<LocationProvider, OrderProvider>(
      builder: (context, locationProvider, orderProvider, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.01),
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
              SizedBox(width: width * 0.026),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Province>(
                    // ...existing code...
                    value:
                        orderProvider.province != null &&
                            locationProvider.provinces.any(
                              (p) => p.id == orderProvider.province!.id,
                            )
                        ? locationProvider.provinces.firstWhere(
                            (p) => p.id == orderProvider.province!.id,
                          )
                        : null,
                    hint: Text(
                      "Select Province",
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: width * 0.035,
                      ),
                    ),
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: textSecondary,
                      size: width * 0.05,
                    ),
                    style: GoogleFonts.abel(
                      fontSize: width * 0.03,
                      color: textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    items: locationProvider.provinces.map((Province province) {
                      return DropdownMenuItem<Province>(
                        value: province,
                        child: Text(
                          province.name,
                          style: GoogleFonts.abel(
                            fontSize: width * 0.038,
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (Province? selectedProvince) {
                      if (selectedProvince != null) {
                        orderProvider.setProvince(selectedProvince);
                        locationProvider.fetchCommunesByProvinceIdFromApi(
                          selectedProvince.id,
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
