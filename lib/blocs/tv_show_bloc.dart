import 'dart:async';

import 'package:lesson_7/models/tv_show.dart';
import 'package:lesson_7/networking/api_response.dart';
import 'package:lesson_7/repository/tv_show_repository.dart';

class TvShowBloc {
  TvShowRepository _tvShowRepository;

  StreamController _streamController;

  StreamSink<ApiResponse<List<TvShow>>> get tvShowSink =>
      _streamController.sink;

  Stream<ApiResponse<List<TvShow>>> get tvShowStream =>
      _streamController.stream;

  TvShowBloc() {
    _tvShowRepository = new TvShowRepository();
    _streamController = StreamController<ApiResponse<List<TvShow>>>();
    fetchTvShowList();
  }

  fetchTvShowList() async {
    tvShowSink.add(ApiResponse.loading('Loading ...'));
    try {
      List<TvShow> listTvShow = await (_tvShowRepository.fetchTvShowJson());
      print(listTvShow);
      tvShowSink.add(ApiResponse.completed(listTvShow));
    } catch (e) {
      tvShowSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _streamController.close();
  }
}
