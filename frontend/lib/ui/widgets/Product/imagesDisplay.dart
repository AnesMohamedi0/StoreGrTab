import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grtabstore/ui/theme/colors.dart';

class ImagesDisplay extends StatefulWidget {
  final List<String> imagesUrl;
  const ImagesDisplay({super.key, required this.imagesUrl});

  @override
  State<ImagesDisplay> createState() => _ImagesDisplayState();
}

class _ImagesDisplayState extends State<ImagesDisplay> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController(); // Changed this line

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController, // This should now work
          options: CarouselOptions(
            height: width * 0.5,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            enlargeCenterPage: true,
            aspectRatio: 0.75,
            enableInfiniteScroll: true,
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.imagesUrl.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: width * 0.8,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: electricBlueDark, width: 2),
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
        SizedBox(height: height * 0.005),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imagesUrl.asMap().entries.map((entry) {
            return Container(
              width: _currentIndex == entry.key ? 16.0 : 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: _currentIndex == entry.key
                    ? electricBlueDark
                    : electricBlueLightest,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
