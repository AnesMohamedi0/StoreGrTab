import 'package:flutter/material.dart';
import 'package:grtabstore/providers/brandsProvider.dart';
import 'package:grtabstore/providers/cartProvider.dart';
import 'package:grtabstore/providers/productsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/Filters/brandFilter.dart';
import 'package:grtabstore/ui/widgets/Home/newAlmost.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  bool isNew = false;
  bool almostSoldOut = false;

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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          AbelText(
            text: "Filter Options",
            fontSize: width * 0.06,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: height * 0.02),
          BrandFilter(),
          SizedBox(height: height * 0.02),

          Row(
            children: [
              AbelText(text: "Status :", fontSize: width * 0.05),
              Expanded(
                child: Consumer<ProductsProvider>(
                  builder: (context, provider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          value: provider.newFilter,
                          onChanged: (value) {
                            provider.triggerFilterByNew();
                          },
                        ),
                        NewAlmostSoldOut(
                          color: accentSuccess,
                          width: width * 0.04,
                          text: ' New ! ',
                        ),
                        SizedBox(width: width * 0.05),
                        Checkbox(
                          value: provider.almostSoldOutFilter,
                          onChanged: (value) {
                            provider.triggerFilterByAlmostSoldOut();
                          },
                        ),
                        NewAlmostSoldOut(
                          color: accentWarning,
                          width: width * 0.04,
                          text: ' Almost Sold Out ... ',
                        ),
                        SizedBox(width: width * 0.05),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
