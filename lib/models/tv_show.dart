import 'package:flutter/material.dart';

class TvShow {
  String originalName;
  String name;
  int voteCount;
  String backdropPath;
  double voteAverage;
  String overView;
  String posterPath;

  TvShow(
      {this.originalName,
      this.name,
      this.voteCount,
      this.backdropPath,
      this.voteAverage,
      this.overView,
      this.posterPath});

  TvShow.fromJson(Map<String, dynamic> json) {
    originalName = json['original_name'];
    name = json['name'];
    voteCount = json['vote_count'];
    backdropPath = json['backdrop_path'];
    voteAverage = json['vote_average'];
    overView = json['overview'];
    posterPath = json['poster_path'];
  }
}
