import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movies.dart';

class api {
  static const trendingurl =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=8ea4b1ccd473d2c153e9c5e30d6ab6c4";
  static const topratedurl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=8ea4b1ccd473d2c153e9c5e30d6ab6c4";
  static const upcomingmovies =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=8ea4b1ccd473d2c153e9c5e30d6ab6c4";

  Future<List<Movie>?> getTrendingMovies() async {
    final Response = await http.get(Uri.parse(trendingurl));
    if (Response.statusCode == 200) {
      final decodedData = json.decode(Response.body)["results"] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('something went wrong');
    }
  }

  Future<List<Movie>?> getTopratedMovies() async {
    final Response = await http.get(Uri.parse(topratedurl));
    if (Response.statusCode == 200) {
      final decodedData = json.decode(Response.body)["results"] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('something went wrong');
    }
  }

  Future<List<Movie>?> getupcomingMovies() async {
    final Response = await http.get(Uri.parse(upcomingmovies));
    if (Response.statusCode == 200) {
      final decodedData = json.decode(Response.body)["results"] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('something went wrong');
    }
  }
}
