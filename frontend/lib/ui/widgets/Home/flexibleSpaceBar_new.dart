import 'package:flutter/material.dart';
import 'package:grtabstore/ui/widgets/Home/logoDisplay.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class CustomFlexibleSpaceContent extends StatelessWidget {
  final double collapseRatio;

  const CustomFlexibleSpaceContent({super.key, required this.collapseRatio});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: collapseRatio <= 0.1
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          // Add top padding when collapsed
          if (collapseRatio <= 0.1) SizedBox(height: 16),

          // Logo above text (only visible when expanded)
          if (collapseRatio > 0.1)
            Opacity(
              opacity: collapseRatio.clamp(0.0, 1.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: LogoDisplay(size: width * 0.15),
              ),
            ),

          // The main title — always visible
          TitlesText(
            text: "Graphics Tablet Store",
            fontSize: width * (collapseRatio <= 0.1 ? 0.045 : 0.06),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),

          // Subtitle below text (only visible when expanded)
          if (collapseRatio > 0.1)
            Opacity(
              opacity: collapseRatio.clamp(0.0, 1.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "Your creative tools hub",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: width * 0.035,
                  ),
                ),
              ),
            ),

          // Add bottom padding when expanded
          if (collapseRatio > 0.1) SizedBox(height: 16),
        ],
      ),
    );
  }
}
