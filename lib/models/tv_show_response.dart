import 'package:lesson_7/models/movie.dart';
import 'package:lesson_7/models/tv_show.dart';

class TvShowResponse {
  int totalPages;
  int totalResults;
  List<TvShow> results;

  TvShowResponse({this.totalPages, this.totalResults, this.results});

  TvShowResponse.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    var listShows;
    if (json['results'] != null) {
      listShows = List<TvShow>();
      json['results'].forEach((value) {
        listShows.add(TvShow.fromJson(value));
      });
    }
  }
}
