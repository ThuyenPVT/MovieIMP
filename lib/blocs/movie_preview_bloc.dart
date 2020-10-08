import 'dart:async';
import 'package:lesson_7/models/movie.dart';
import 'package:lesson_7/models/movie_preview.dart';
import 'package:lesson_7/networking/api_response.dart' show ApiResponse;
import 'package:lesson_7/repository/movie_preview_repository.dart';
import 'package:lesson_7/repository/movie_repository.dart';

class MoviePreviewBloc {
  MoviePreviewRepository _movieRepository;
  StreamController _movieListController;

  StreamSink<ApiResponse<List<MoviePreview>>> get movieListPreviewSink =>
      _movieListController.sink;

  Stream<ApiResponse<List<MoviePreview>>> get movieListPreviewStream =>
      _movieListController.stream;

  int movieId;
  MoviePreviewBloc({this.movieId}) {
    _movieListController = StreamController<ApiResponse<List<MoviePreview>>>();
    _movieRepository = MoviePreviewRepository();
    fetchMoviePreviewList(movieId);
  }

  fetchMoviePreviewList(int movieID) async {
    movieListPreviewSink.add(ApiResponse.loading('Loading ...'));
    try {
      List<MoviePreview> moviesPreview =
          (await _movieRepository.fetchMoviePreview(movieID))
              .cast<MoviePreview>();
      movieListPreviewSink.add(ApiResponse.completed(moviesPreview));
    } catch (e) {
      movieListPreviewSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieListController?.close();
  }
}
