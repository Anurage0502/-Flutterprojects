import 'package:flutter/material.dart';
import 'package:movbuzz/constants.dart';

import 'detailscreen.dart';

class moviesslider extends StatelessWidget {
  const moviesslider({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 200,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detailscreen(
                                    mmovies: snapshot.data[index])));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: SizedBox(
                          height: 200,
                          width: 100,
                          child: Image.network(
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              '${Constants.imagepath}${snapshot.data![index].poster_path}'),
                        ),
                      ),
                    )),
              );
            }));
  }
}
