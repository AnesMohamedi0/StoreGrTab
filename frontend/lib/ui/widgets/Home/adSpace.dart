import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/ad.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Adspace extends StatelessWidget {
  final Ad ad;
  final double height;
  const Adspace({super.key, required this.ad, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: deepPurple,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ad.imageUrl != null
                ? Image.network(ad.imageUrl!, fit: BoxFit.cover)
                : Container(),
          ),
          Positioned(
            bottom: height * 0.05,
            left: height * 0.05,
            child: SizedBox(
              child: TitlesText(
                text: ad.title,
                fontSize: height * 0.15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.05,
            right: height * 0.05,
            child: SizedBox(
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.open_in_new_rounded,
                  color: Colors.white,
                  size: height * 0.15,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
