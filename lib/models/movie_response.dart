import 'dart:convert';

import 'package:lesson_7/models/movie.dart';

class MovieResponse {
  int totalResults;
  List<Movie> results;
  int page;
  int totalPages;

  MovieResponse({this.page, this.totalResults, this.totalPages, this.results});

  MovieResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    if (json['results'] != null) {
      results = List<Movie>();
      json['results'].forEach((v) {
        results.add( Movie.fromJson(v));
      });
    }
  }
}