import 'dart:async';
import 'package:lesson_7/models/movie.dart';
import 'package:lesson_7/networking/api_response.dart' show ApiResponse;
import 'package:lesson_7/repository/movie_repository.dart';

class MovieBloc {
  MovieRepository _movieRepository;
  StreamController _movieListController;

  StreamSink<ApiResponse<List<Movie>>> get movieListSink =>
      _movieListController.sink;

  Stream<ApiResponse<List<Movie>>> get movieListStream =>
      _movieListController.stream;

  MovieBloc() {
    _movieListController = StreamController<ApiResponse<List<Movie>>>();
    _movieRepository = MovieRepository();
    fetchMovieList();
  }

  fetchMovieList() async {
    movieListSink.add(ApiResponse.loading('Loading ...'));
    try {
      List<Movie> movies = (await _movieRepository.fetchMovieList()).cast<Movie>();
      movieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieListController?.close();
  }
}
