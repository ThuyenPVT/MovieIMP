
import 'package:lesson_7/models/movie.dart';
import 'package:lesson_7/models/movie_preview.dart';
import 'package:lesson_7/models/movie_preview_response.dart';
import 'package:lesson_7/models/movie_response.dart';
import 'package:lesson_7/networking/api_base_helper.dart';
import 'package:lesson_7/utils/Constant.dart';

class MoviePreviewRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<MoviePreview>> fetchMoviePreview(int id) async {
    final response = await _helper.get("id/videos?api_key=${Constant.apiKey}&language=en-US");
    return MoviePreviewResponse.fromJson(response).results;
  }

}