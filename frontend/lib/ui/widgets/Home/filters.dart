import 'package:flutter/material.dart';
import 'package:grtabstore/providers/productsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/filterSortButton.dart';
import 'package:grtabstore/ui/widgets/Home/filtersheet.dart';
import 'package:grtabstore/ui/widgets/Home/searchBar.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class FiltersSpace extends StatelessWidget {
  final double height;
  const FiltersSpace({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cardBackground, cardBackgroundSecondary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: SearchBarFilter()),
              SizedBox(width: width * 0.02),
              FilterSortButton(
                label: 'Filter',
                icon: Icon(
                  Icons.filter_alt_sharp,
                  color: textOnDark,
                  size: height * 0.32,
                ),
                function: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // full-height if needed
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return const FilterSheet();
                    },
                  );
                },
                size: height * 0.7,
              ),
              SizedBox(width: width * 0.02),
              FilterSortButton(
                label: 'Sort',
                icon: Icon(Icons.sort, color: textOnDark, size: height * 0.32),
                function: () {},
                size: height * 0.7,
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
          Consumer<ProductsProvider>(
            builder: (context, productsProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: width * 0.02),
                  AbelText(
                    text:
                        'Found ${productsProvider.filteredProducts.length} products, ${productsProvider.getNumberFilters()} filters applied',
                    fontSize: height * 0.14,
                    color: textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
