import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/brand.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/providers/brandsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class ProductNameDisplay extends StatelessWidget {
  final Product product;
  const ProductNameDisplay({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Brand? brand = context.read<BrandsProvider>().getBrandById(product.brandId);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.1,
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: AbelText(
              text: product.name,
              fontSize: width * 0.07,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          Positioned(
            top: height * 0.04,
            left: width * 0.005,
            child: TitlesText(
              text: 'From ${brand?.name ?? 'Unknown Brand'}',
              fontSize: width * 0.045,
              color: textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
