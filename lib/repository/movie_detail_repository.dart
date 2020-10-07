
import 'package:lesson_7/models/movie.dart';
import 'package:lesson_7/networking/api_base_helper.dart';
import 'package:lesson_7/utils/Constant.dart';

class MovieDetailRepository {

  ApiBaseHelper _helper = ApiBaseHelper();
  Future<Movie> fetchMovieDetail(int selectedMovie) async {
    final response = await _helper.get("movie/$selectedMovie?api_key=${Constant.apiKey}");
    return Movie.fromJson(response);

  }

}