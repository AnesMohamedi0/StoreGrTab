import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/infoDialog.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class ItemDescription extends StatelessWidget {
  final Product product;
  const ItemDescription({super.key, required this.product});

  void _showInfoDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InfoDialog(title: title, description: description);
      },
    );
  }

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
              Icon(Icons.aspect_ratio, color: textPrimary, size: width * 0.05),
              SizedBox(width: width * 0.02),
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
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Active Area (Dimensions):',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _showInfoDialog(
                        context,
                        'Active Area',
                        'The active area is the working surface of the tablet where your stylus movements are detected. This measurement shows the width and height in inches of the drawing area you can use.',
                      );
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
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Dimensions:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _showInfoDialog(
                        context,
                        'Dimensions',
                        'The overall physical size of the tablet including the border and frame. This tells you how much desk space the tablet will occupy.',
                      );
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
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Connection Type:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _showInfoDialog(
                        context,
                        'Connection Type',
                        'How the tablet connects to your computer. Wired tablets connect via USB cable, wireless tablets connect via Bluetooth or wireless receiver, and some support both options.',
                      );
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
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'USB Port Type:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _showInfoDialog(
                        context,
                        'USB Port Type',
                        'The type of USB connector used by the tablet. USB-C is the newest standard with faster data transfer and reversible connection. USB-A is the traditional rectangular connector. Some tablets may use Micro-USB.',
                      );
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
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Compatible with:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _showInfoDialog(
                        context,
                        'Compatible Operating Systems',
                        'The operating systems that support this tablet. Most tablets work with Windows, macOS, and Linux. Some may have limited functionality on certain systems, so check compatibility before purchasing.',
                      );
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
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Report Rate:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _showInfoDialog(
                        context,
                        'Report Rate',
                        'How many times per second the tablet reports your pen position to the computer (RPS = Reports Per Second). Higher values mean smoother and more responsive drawing. Professional artists typically prefer 200+ RPS.',
                      );
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
                  SizedBox(width: width * 0.01),
                  AbelText(
                    text: 'Resolution:',
                    fontSize: width * 0.038,
                    color: textSecondary,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _showInfoDialog(
                        context,
                        'Resolution',
                        'The precision of the tablet measured in Lines Per Inch (LPI). Higher resolution means the tablet can detect smaller movements and provide more accurate drawing. Professional tablets typically have 2540+ LPI.',
                      );
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
