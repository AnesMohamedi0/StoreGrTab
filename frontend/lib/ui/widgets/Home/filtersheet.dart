import 'package:flutter/material.dart';
import 'package:grtabstore/providers/brandsProvider.dart';
import 'package:grtabstore/providers/productsProvider.dart';
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
      padding: EdgeInsets.all(width * 0.03),
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
          Row(
            children: [
              AbelText(text: "Status :", fontSize: width * 0.045),
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
                        AbelText(text: "New", fontSize: width * 0.04),
                        SizedBox(width: width * 0.05),
                        Checkbox(
                          value: provider.almostSoldOutFilter,
                          onChanged: (value) {
                            provider.triggerFilterByAlmostSoldOut();
                          },
                        ),
                        AbelText(
                          text: "Almost Sold Out",
                          fontSize: width * 0.04,
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
