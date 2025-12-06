import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grtabstore/providers/HomeProviders/productsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:provider/provider.dart';

TextEditingController searchController = TextEditingController();

class SearchBarFilter extends StatelessWidget {
  const SearchBarFilter({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
      child: TextField(
        style: GoogleFonts.abel(
          fontSize: width * 0.034,
          color: textSecondary,
          fontWeight: FontWeight.w600,
        ),
        controller: searchController,
        onChanged: (value) {
          Provider.of<ProductsProvider>(
            context,
            listen: false,
          ).filterByName(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search...',
          isDense: true,
          contentPadding: EdgeInsets.zero,
          icon: Icon(Icons.search, color: textSecondary, size: width * 0.06),
        ),
      ),
    );
  }
}
