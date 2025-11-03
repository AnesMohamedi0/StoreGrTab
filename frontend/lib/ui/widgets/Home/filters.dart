import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';

class FiltersSpace extends StatelessWidget {
  final double height;
  const FiltersSpace({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: deepPurpleLightest,
    );
  }
}
