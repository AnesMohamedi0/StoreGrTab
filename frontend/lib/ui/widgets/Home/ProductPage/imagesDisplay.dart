import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFooter.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class ImagesDisplay extends StatefulWidget {
  final List<String> imagesUrl;
  const ImagesDisplay({super.key, required this.imagesUrl});

  @override
  State<ImagesDisplay> createState() => _ImagesDisplayState();
}

class _ImagesDisplayState extends State<ImagesDisplay> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: width * 0.71,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          AnimatedFooter(),
          CarouselSlider(
            carouselController: _carouselController, // This should now work
            options: CarouselOptions(
              height: width * 0.7,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              enlargeCenterPage: true,
              aspectRatio: 0.7,
              enableInfiniteScroll: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: widget.imagesUrl.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: width,
                    child: ClipRRect(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(Icons.image, size: 50),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              color: const Color.fromARGB(179, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AbelText(
                    text: '${currentIndex + 1}',
                    fontSize: width * 0.035,
                    color: white,
                    fontWeight: FontWeight.bold,
                  ),
                  AbelText(
                    text: '/${widget.imagesUrl.length}',
                    fontSize: width * 0.025,
                    color: secondaryBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
