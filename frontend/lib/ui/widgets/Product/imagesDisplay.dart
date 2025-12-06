import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFooter.dart';

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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      //border: Border.all(color: electricBlueDark, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
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
        ],
      ),
    );
  }
}
