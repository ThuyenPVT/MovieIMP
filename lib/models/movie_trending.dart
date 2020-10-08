

class MovieTrending {
  int id;
  var voteCount;
  var voteAverage;
  String title;
  String releaseDate;
  String backdropPath;
  String overview;
  String posterPath;
  var popularity;

  MovieTrending(
      {  this.id,
      this.voteCount,
      this.voteAverage,
      this.title,
      this.releaseDate,
      this.backdropPath,
      this.overview,
      this.posterPath,
      this.popularity,});

  MovieTrending.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'];
    title = json['title'];
    releaseDate = json['release_date'];
    backdropPath = json['backdrop_path'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    popularity = json['popularity'];
  }
}