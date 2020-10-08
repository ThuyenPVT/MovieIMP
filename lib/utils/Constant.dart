import 'package:lesson_7/models/movie.dart';

class Constant {
  static final baseUrl = "http://api.themoviedb.org/3/";

  static final apiKey = "30657e2bca6d1fabd3d0f90331e6dfb6";

  static final youtubeUrl = "https://www.youtube.com/watch?v=";
}

class Common {
  static final movieBookmarked = Set<Movie>();
  static final movieId = Set<int>();
}
