// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

class Movie {
  int id;
  var voteAverage;
  String title;
  String posterPath;
  String overview;
  String releaseDate;

  Movie(
      {this.id,
      this.voteAverage,
      this.title,
      this.posterPath,
      this.overview,
      this.releaseDate});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voteAverage = json['vote_average'];
    title = json['title'];
    posterPath = json['poster_path'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }
}
