import 'package:flutter/material.dart';
import 'package:grtabstore/providers/HomeProviders/brandsProvider.dart';
import 'package:grtabstore/providers/HomeProviders/productsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class BrandFilter extends StatelessWidget {
  const BrandFilter({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AbelText(text: "Brand :", fontSize: width * 0.05),
        Expanded(
          child: Consumer2<ProductsProvider, BrandsProvider>(
            builder: (context, productsProvider, brandsProvider, child) {
              int getOptimalCrossAxisCount() {
                final brandCount = brandsProvider.brands.length;
                final availableWidth =
                    width * 0.7; // Approximate available width
                final minCardWidth =
                    width * 0.2; // Minimum width for each brand card

                // Calculate max possible cards per row based on width
                int maxByWidth = (availableWidth / minCardWidth).floor();

                // Limit by brand count (no empty cards)
                int maxByBrands = brandCount;

                // Choose the smaller value, with min of 2 and max of 6
                return (maxByWidth < maxByBrands ? maxByWidth : maxByBrands)
                    .clamp(2, 6);
              }

              final crossAxisCount = getOptimalCrossAxisCount();

              return Container(
                margin: EdgeInsets.only(left: width * 0.04),
                child: GridView.builder(
                  shrinkWrap: true, // Important: prevents infinite height
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scroll if needed
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 3,
                    crossAxisSpacing: width * 0.02,
                    mainAxisSpacing: width * 0.02,
                  ),
                  itemCount: brandsProvider.brands.length, // ✅ Add this line
                  itemBuilder: (context, index) {
                    final brand = brandsProvider.brands[index];
                    final isSelected = productsProvider.brandFilter.contains(
                      brand.brandId,
                    );

                    return TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        // Toggle brand filter
                        if (isSelected) {
                          productsProvider.clearFilterByBrand(brand.brandId);
                        } else {
                          productsProvider.filterByBrandId(brand.brandId);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: width * 0.01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: textPrimary, width: 1.5),
                          color: !isSelected ? Colors.transparent : textPrimary,
                        ),
                        child: AbelText(
                          text: brand.name,
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: !isSelected ? textPrimary : textOnDark,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
