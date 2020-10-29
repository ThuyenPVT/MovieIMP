import 'package:lesson_7/networking/api_base_helper.dart';
import 'package:lesson_7/models/tv_show.dart';
import 'package:lesson_7/models/tv_show_response.dart';
import 'package:lesson_7/utils/Constant.dart';

class TvShowRepository {
  final _apiHelper = ApiBaseHelper();

  Future<List<TvShow>> fetchTvShowJson() async {
    var response = await _apiHelper.get(
        'discover/tv?api_key=${Constant.apiKey}&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false');
    return TvShowResponse.fromJson(response).results;
  }
}
