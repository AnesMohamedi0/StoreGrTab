import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grtabstore/ui/theme/colors.dart';

class TextForm extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon icon;
  final bool onlyNumbers;
  final ValueChanged<String>? onChange;

  const TextForm({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.onlyNumbers = false,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      padding: EdgeInsets.only(
        right: width * 0.02,
        top: height * 0.007,
        bottom: height * 0.005,
        left: width * 0.02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: textPrimary, width: 1.5),
      ),
      height: height * 0.045,
      child: TextField(
        style: GoogleFonts.abel(
          fontSize: width * 0.034,
          color: textPrimary,
          fontWeight: FontWeight.w600,
        ),
        onChanged: onChange,
        controller: controller,
        keyboardType: onlyNumbers ? TextInputType.number : TextInputType.text,
        inputFormatters: onlyNumbers
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          icon: icon,
        ),
      ),
    );
  }
}
