import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import
import 'package:provider/provider.dart';
import 'package:grtabstore/providers/productsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class SizeFilter extends StatefulWidget {
  const SizeFilter({super.key});

  @override
  State<SizeFilter> createState() => _SizeFilterState();
}

class _SizeFilterState extends State<SizeFilter> {
  late TextEditingController _minSizeController;
  late TextEditingController _maxSizeController;

  @override
  void initState() {
    super.initState();
    _minSizeController = TextEditingController();
    _maxSizeController = TextEditingController();
  }

  @override
  void dispose() {
    _minSizeController.dispose();
    _maxSizeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Load saved values from provider
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    double minSize = provider.getMinSizeFilter() ?? 0.0;
    double maxSize = provider.getMaxSizeFilter() ?? double.infinity;

    _minSizeController.text = minSize == 0.0 ? '' : minSize.toString();
    _maxSizeController.text = maxSize == double.infinity
        ? ''
        : maxSize.toString();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Row(
      children: [
        AbelText(text: "Size :", fontSize: width * 0.05),
        Expanded(
          child: Consumer<ProductsProvider>(
            builder: (context, provider, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Min Size Field
                  AbelText(text: "From", fontSize: width * 0.04),
                  SizedBox(width: width * 0.02),

                  _buildSizeField(
                    controller: _minSizeController,
                    hint: 'Min',
                    width: width,
                    height: height,
                    onChanged: (value) {
                      provider.filterBySizeRange(
                        double.tryParse(_minSizeController.text) ?? 0.0,
                        double.tryParse(_maxSizeController.text) ??
                            double.infinity,
                      );
                    },
                  ),

                  SizedBox(width: width * 0.02),
                  AbelText(text: "To", fontSize: width * 0.04),
                  SizedBox(width: width * 0.02),

                  // Max Size Field
                  _buildSizeField(
                    controller: _maxSizeController,
                    hint: 'Max',
                    width: width,
                    height: height,
                    onChanged: (value) {
                      provider.filterBySizeRange(
                        double.tryParse(_minSizeController.text) ?? 0.0,
                        double.tryParse(_maxSizeController.text) ??
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

  Widget _buildSizeField({
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
          suffixText: '"',
          suffixStyle: TextStyle(fontSize: width * 0.035, color: textPrimary),
          hintText: hint,
          hintStyle: TextStyle(fontSize: width * 0.03, color: textPrimary),
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        style: TextStyle(fontSize: width * 0.035, color: textPrimary),
      ),
    );
  }
}
