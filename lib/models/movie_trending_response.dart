import 'dart:convert';

import 'package:lesson_7/models/movie.dart';

import 'movie_trending.dart';

class MovieTrendingResponse {
  int page;
  List<MovieTrending> results;

  MovieTrendingResponse({this.page, this.results});

  MovieTrendingResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results = (json['results'] as List).map((json) => MovieTrending.fromJson(json)).toList();
  }
}