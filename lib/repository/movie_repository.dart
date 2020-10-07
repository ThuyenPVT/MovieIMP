
import 'package:lesson_7/models/movie.dart';
import 'package:lesson_7/models/movie_response.dart';
import 'package:lesson_7/networking/api_base_helper.dart';
import 'package:lesson_7/utils/Constant.dart';

class MovieRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Movie>> fetchMovieList() async {
    final response = await _helper.get("movie/popular?api_key=${Constant.apiKey}");

    return MovieResponse.fromJson(response).results;
  }

}