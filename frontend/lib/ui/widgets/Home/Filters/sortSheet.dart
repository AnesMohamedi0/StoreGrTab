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

class SortSheet extends StatefulWidget {
  const SortSheet({super.key});

  @override
  State<SortSheet> createState() => _SortSheetState();
}

class _SortSheetState extends State<SortSheet> {
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
              Icon(Icons.sort, size: width * 0.07, color: textPrimary),
              SizedBox(width: width * 0.01),
              AbelText(
                text: "Sort Options",
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: width * 0.05),
              IconButton(
                onPressed: () {
                  context.read<ProductsProvider>().clearSortOptions();
                },
                icon: Icon(
                  Icons.rotate_left_sharp,
                  size: width * 0.08,
                  color: textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.03),
          SizedBox(
            width: double.infinity,
            child: Consumer<ProductsProvider>(
              builder: (context, productsProvider, child) {
                return Column(
                  spacing: height * 0.01,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SortButton(
                      size: width,
                      ascending: false,
                      label: "Price: High to Low",
                      function: () {
                        context.read<ProductsProvider>().sortByPrice(
                          ascending: false,
                        );
                      },
                      isSelected: productsProvider.sortOption == 2,
                    ),
                    SortButton(
                      size: width,
                      ascending: true,
                      label: "Price: Low to High",
                      function: () {
                        context.read<ProductsProvider>().sortByPrice(
                          ascending: true,
                        );
                      },
                      isSelected: productsProvider.sortOption == 1,
                    ),
                    SortButton(
                      size: width,
                      ascending: true,
                      label: "Size: Small to Large",
                      function: () {
                        context.read<ProductsProvider>().sortByActifAreaX(
                          ascending: true,
                        );
                      },
                      isSelected: productsProvider.sortOption == 5,
                    ),
                    SortButton(
                      size: width,
                      ascending: false,
                      label: "Size: Large to Small",
                      function: () {
                        context.read<ProductsProvider>().sortByActifAreaX(
                          ascending: false,
                        );
                      },
                      isSelected: productsProvider.sortOption == 6,
                    ),
                    SortButton(
                      size: width,
                      ascending: false,
                      label: "Name: A to Z",
                      function: () {
                        context.read<ProductsProvider>().sortByName(
                          ascending: false,
                        );
                      },
                      isSelected: productsProvider.sortOption == 4,
                    ),
                    SortButton(
                      size: width,
                      ascending: true,
                      label: "Name: Z to A",
                      function: () {
                        context.read<ProductsProvider>().sortByName(
                          ascending: true,
                        );
                      },
                      isSelected: productsProvider.sortOption == 3,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SortButton extends StatelessWidget {
  final bool isSelected;
  final double size;
  final bool ascending;
  final String label;
  final VoidCallback? function;

  const SortButton({
    super.key,
    required this.size,
    required this.ascending,
    required this.label,
    this.function,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
          function ??
          () {
            context.read<ProductsProvider>().sortByName(ascending: ascending);
          },
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.circle_rounded : Icons.circle_outlined,
            size: size * 0.05,
            color: textPrimary,
          ),
          SizedBox(width: size * 0.02),
          AbelText(text: label, fontSize: size * 0.05),
          SizedBox(width: size * 0.02),
          Icon(
            ascending ? Icons.arrow_downward : Icons.arrow_upward,
            size: size * 0.05,
            color: textPrimary,
          ),
        ],
      ),
    );
  }
}
