import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movbuzz/api/api.dart';
import 'package:movbuzz/models/movies.dart';
import 'package:movbuzz/moviesslider.dart';
import 'package:movbuzz/trendingslider.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  final TextEditingController search = TextEditingController();
  late Future<List<Movie>?> trendingmovies;
  late Future<List<Movie>?> toprated;
  late Future<List<Movie>?> upcoming;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trendingmovies = api().getTrendingMovies();
    toprated = api().getTopratedMovies();
    upcoming = api().getupcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            'assests/vflix.png',
            height: 50,
            width: 50,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
          toolbarHeight: 50,
          shadowColor: Colors.black,
          scrolledUnderElevation: 60,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 300,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                  color: Colors.amber,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: search,
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.search_outlined))
                    ],
                  ),
                ),
              ),
            ),
          ]),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Movies',
                style:
                    GoogleFonts.syne(fontSize: 25, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 15),
              SizedBox(
                child: FutureBuilder(
                    future: trendingmovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return trendingSlider(
                          snapshot: snapshot,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Top rated Movies',
                style:
                    GoogleFonts.syne(fontSize: 25, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 15),
              SizedBox(
                child: FutureBuilder(
                    future: toprated,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return moviesslider(
                          snapshot: snapshot,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Upcoming Movies',
                style:
                    GoogleFonts.syne(fontSize: 25, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 15),
              SizedBox(
                child: FutureBuilder(
                    future: upcoming,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return moviesslider(
                          snapshot: snapshot,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
