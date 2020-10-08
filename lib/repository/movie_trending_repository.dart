

import 'package:lesson_7/models/movie_trending.dart';
import 'package:lesson_7/models/movie_trending_response.dart';
import 'package:lesson_7/networking/api_base_helper.dart';
import 'package:lesson_7/utils/Constant.dart';

class MovieTrendingRepository {
  ApiBaseHelper _apiHelper = ApiBaseHelper();

  Future<List<MovieTrending>> fetchTvShowJson() async {
    var response = await _apiHelper.get('trending/all/day?api_key=${Constant.apiKey}');
    print(response);
    return MovieTrendingResponse.fromJson(response).results;
  }
}