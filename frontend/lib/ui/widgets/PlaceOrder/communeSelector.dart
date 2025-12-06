import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grtabstore/data/models/commune.dart';
import 'package:grtabstore/providers/HomeProviders/locationProvider.dart';
import 'package:grtabstore/providers/HomeProviders/orderProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:provider/provider.dart';

class CommuneSelector extends StatelessWidget {
  const CommuneSelector({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (Provider.of<OrderProvider>(context).province == null) {
      return SizedBox.shrink();
    }

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
              Icon(
                Icons.location_city,
                color: textSecondary,
                size: width * 0.05,
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Commune>(
                    // Current selected value
                    value:
                        orderProvider.commune != null &&
                            locationProvider.communes.any(
                              (c) => c.id == orderProvider.commune!.id,
                            )
                        ? locationProvider.communes.firstWhere(
                            (c) => c.id == orderProvider.commune!.id,
                          )
                        : null,

                    // Hint text when nothing is selected
                    hint: Text(
                      "Select Commune",
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

                    style: GoogleFonts.abel(
                      fontSize: width * 0.03,
                      color: textPrimary,
                      fontWeight: FontWeight.w600,
                    ),

                    // Dropdown items
                    items: locationProvider.communes.map((Commune commune) {
                      return DropdownMenuItem<Commune>(
                        value: commune,
                        child: Text(
                          commune.name,
                          style: GoogleFonts.abel(
                            fontSize: width * 0.038,
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),

                    // When user selects an item
                    onChanged: (Commune? selectedCommune) {
                      if (selectedCommune != null) {
                        orderProvider.setCommune(selectedCommune);
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
