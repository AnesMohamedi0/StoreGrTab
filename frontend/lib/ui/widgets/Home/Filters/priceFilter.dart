import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:grtabstore/providers/productsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class PriceFilter extends StatefulWidget {
  const PriceFilter({super.key});

  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;

  @override
  void initState() {
    super.initState();
    _minPriceController = TextEditingController();
    _maxPriceController = TextEditingController();
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Load saved values from provider
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    double minPrice = provider.getMinPriceFilter() ?? 0.0;
    double maxPrice = provider.getMaxPriceFilter() ?? double.infinity;

    _minPriceController.text = minPrice == 0.0 ? '' : minPrice.toString();
    _maxPriceController.text = maxPrice == double.infinity
        ? ''
        : maxPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Row(
      children: [
        AbelText(text: "Price :", fontSize: width * 0.05),
        Expanded(
          child: Consumer<ProductsProvider>(
            builder: (context, provider, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Min Price Field
                  AbelText(text: "From", fontSize: width * 0.04),
                  SizedBox(width: width * 0.02),

                  _buildPriceField(
                    controller: _minPriceController,
                    hint: 'Min',
                    width: width,
                    height: height,
                    onChanged: (value) {
                      provider.filterByPriceRange(
                        double.tryParse(_minPriceController.text) ?? 0.0,
                        double.tryParse(_maxPriceController.text) ??
                            double.infinity,
                      );
                    },
                  ),

                  SizedBox(width: width * 0.02),
                  AbelText(text: "To", fontSize: width * 0.04),
                  SizedBox(width: width * 0.02),

                  // Max Price Field
                  _buildPriceField(
                    controller: _maxPriceController,
                    hint: 'Max',
                    width: width,
                    height: height,
                    onChanged: (value) {
                      provider.filterByPriceRange(
                        double.tryParse(_minPriceController.text) ?? 0.0,
                        double.tryParse(_maxPriceController.text) ??
                            double.infinity,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPriceField({
    required TextEditingController controller,
    required String hint,
    required double width,
    required double height,
    required Function(String) onChanged,
  }) {
    return Container(
      width: width * 0.23,
      margin: EdgeInsets.symmetric(horizontal: width * 0.015),
      padding: EdgeInsets.only(
        right: width * 0.02,
        top: height * 0.003,
        bottom: height * 0.001,
        left: width * 0.02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: textPrimary, width: 1.5),
      ),
      height: height * 0.04,
      child: TextField(
        style: GoogleFonts.abel(
          fontSize: width * 0.035,
          color: textPrimary,
          fontWeight: FontWeight.bold,
        ),
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(
          decimal: true,
        ), // Allow decimals
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d*\.?\d*'),
          ), // Numbers and decimal point only
        ],
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixText: "DA",
          suffixStyle: TextStyle(fontSize: width * 0.035, color: textPrimary),
          hintText: hint,
          hintStyle: TextStyle(fontSize: width * 0.03, color: textPrimary),
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
