import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class ItemDescription extends StatelessWidget {
  final Product product;
  const ItemDescription({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Column(
        children: [
          Row(
            children: [
              AbelText(
                text: 'Product Description:',
                fontSize: width * 0.048,
                color: textPrimary,
              ),
            ],
          ),

          SizedBox(height: height * 0.01),

          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.aspect_ratio,
                    color: textSecondary,
                    size: width * 0.06,
                  ),
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Active Area (Dimensions):',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Handle icon button press
                    },
                    icon: Icon(
                      Icons.info,
                      color: textTertiary,
                      size: width * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.03),

              AbelText(
                text: '${product.actifAreaX}*',
                fontSize: width * 0.04,
                color: textPrimary,
              ),
              SizedBox(width: width * 0.01),
              AbelText(
                text: '${product.actifAreaY} inches',
                fontSize: width * 0.04,
                color: textPrimary,
              ),
              SizedBox(width: width * 0.01),
            ],
          ),

          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.aspect_ratio,
                    color: textSecondary,
                    size: width * 0.06,
                  ),
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Dimensions:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Handle icon button press
                    },
                    icon: Icon(
                      Icons.info,
                      color: textTertiary,
                      size: width * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.03),

              AbelText(
                text: product.dimensions,
                fontSize: width * 0.04,
                color: textPrimary,
              ),
            ],
          ),

          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.cast_connected,
                    color: textSecondary,
                    size: width * 0.06,
                  ),
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Connection Type:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Handle icon button press
                    },
                    icon: Icon(
                      Icons.info,
                      color: textTertiary,
                      size: width * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.03),

              AbelText(
                text: product.getConnectionTypeText(),
                fontSize: width * 0.04,
                color: textPrimary,
              ),
            ],
          ),

          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.usb, color: textSecondary, size: width * 0.06),
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'USB Port Type:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Handle icon button press
                    },
                    icon: Icon(
                      Icons.info,
                      color: textTertiary,
                      size: width * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.03),

              AbelText(
                text: product.getUSBPortTypeText(),
                fontSize: width * 0.04,
                color: textPrimary,
              ),
            ],
          ),

          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.computer,
                    color: textSecondary,
                    size: width * 0.06,
                  ),
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Compatible with:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Handle icon button press
                    },
                    icon: Icon(
                      Icons.info,
                      color: textTertiary,
                      size: width * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.03),

              AbelText(
                text: product.getSupportedOSList().join(", "),
                fontSize: width * 0.04,
                color: textPrimary,
              ),
            ],
          ),

          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.speaker_phone_rounded,
                    color: textSecondary,
                    size: width * 0.06,
                  ),
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Report Rate:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Handle icon button press
                    },
                    icon: Icon(
                      Icons.info,
                      color: textTertiary,
                      size: width * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.03),

              AbelText(
                text: '${product.reportRate} RPS',
                fontSize: width * 0.04,
                color: textPrimary,
              ),
            ],
          ),

          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.tablet, color: textSecondary, size: width * 0.06),
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Resolution:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Handle icon button press
                    },
                    icon: Icon(
                      Icons.info,
                      color: textTertiary,
                      size: width * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.03),

              AbelText(
                text: '${product.resolution} LPI',
                fontSize: width * 0.04,
                color: textPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
