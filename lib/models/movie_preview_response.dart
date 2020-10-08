

import 'package:lesson_7/models/movie_preview.dart';

class MoviePreviewResponse {
  int id;
  List<MoviePreview> results;

  MoviePreviewResponse({this.id,this.results});

  MoviePreviewResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    results = (json['results'] as List).map((json) => MoviePreview.fromJson(json)).toList();
  }
}