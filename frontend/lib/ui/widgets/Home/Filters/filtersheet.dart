import 'package:flutter/material.dart';
import 'package:grtabstore/providers/brandsProvider.dart';
import 'package:grtabstore/providers/cartProvider.dart';
import 'package:grtabstore/providers/productsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/Filters/brandFilter.dart';
import 'package:grtabstore/ui/widgets/Home/Filters/priceFilter.dart';
import 'package:grtabstore/ui/widgets/Home/Filters/sizeFilter.dart';
import 'package:grtabstore/ui/widgets/Home/Filters/statueFilter.dart';
import 'package:grtabstore/ui/widgets/Home/Product/newAlmost.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.5,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.06,
        vertical: height * 0.03,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        gradient: LinearGradient(
          colors: [Colors.white, deepPurpleLightest],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.filter_alt_sharp,
                size: width * 0.07,
                color: textPrimary,
              ),
              SizedBox(width: width * 0.01),
              AbelText(
                text: "Filter Options",
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: width * 0.05),
              IconButton(
                onPressed: () {
                  context.read<ProductsProvider>().clearAllFilter();
                },
                icon: Icon(
                  Icons.rotate_left_sharp,
                  size: width * 0.08,
                  color: textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
          BrandFilter(),
          SizedBox(height: height * 0.02),
          StatueFilter(),
          SizedBox(height: height * 0.02),
          PriceFilter(),
          SizedBox(height: height * 0.02),
          SizeFilter(),
        ],
      ),
    );
  }
}
