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
    results = (json['results'] as List).map((json) => Movie.fromJson(json)).toList();
  }
}