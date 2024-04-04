import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movbuzz/constants.dart';
import 'package:movbuzz/detailscreen.dart';

class trendingSlider extends StatelessWidget {
  const trendingSlider({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: snapshot.data.length,
          options: CarouselOptions(
            height: 300,
            autoPlay: true,
            viewportFraction: 0.55,
            autoPlayCurve: Curves.easeInBack,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            enlargeCenterPage: true,
            pageSnapping: true,
          ),
          itemBuilder: (context, itemIndex, PageViewIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            detailscreen(mmovies: snapshot.data[itemIndex])));
              },
              child: Image.network(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  '${Constants.imagepath}${snapshot.data[itemIndex].poster_path}'),
            );
          }),
    );
  }
}
