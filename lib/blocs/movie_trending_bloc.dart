import 'dart:async';
import 'package:lesson_7/models/movie_trending.dart';
import 'package:lesson_7/models/tv_show.dart';
import 'package:lesson_7/networking/api_response.dart';
import 'package:lesson_7/repository/movie_trending_repository.dart';

class MovieTrendingBloc {
  MovieTrendingRepository _movieTrendingRepository;

  StreamController _streamController;

  StreamSink<ApiResponse<List<MovieTrending>>> get movieTrendingSink =>
      _streamController.sink;

  Stream<ApiResponse<List<MovieTrending>>> get movieTrendingStream =>
      _streamController.stream;

  MovieTrendingBloc() {
    _movieTrendingRepository = new MovieTrendingRepository();
    _streamController = StreamController<ApiResponse<List<MovieTrending>>>();
    fetchMovieTrendingList();
  }

  fetchMovieTrendingList() async {
    movieTrendingSink.add(ApiResponse.loading('Loading ...'));
    try {
      List<MovieTrending> listMovieTrending = await (_movieTrendingRepository.fetchTvShowJson());
      print(listMovieTrending);
      movieTrendingSink.add(ApiResponse.completed(listMovieTrending));
    } catch (e) {
      movieTrendingSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _streamController.close();
  }
}
