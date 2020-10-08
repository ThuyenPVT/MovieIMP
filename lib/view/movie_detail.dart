import 'package:flutter/material.dart';
import 'package:lesson_7/blocs/movie_detail_bloc.dart';
import 'package:lesson_7/models/movie.dart';
import 'package:lesson_7/networking/api_response.dart';
import 'package:lesson_7/utils/Constant.dart';
import 'package:share/share.dart';

class MovieDetail extends StatefulWidget {
  final int selectedMovie;

  const MovieDetail(this.selectedMovie);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = MovieDetailBloc(widget.selectedMovie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Moviez',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Piazzolla',
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            _movieDetailBloc.fetchMovieDetail(widget.selectedMovie),
        child: StreamBuilder<ApiResponse<Movie>>(
          stream: _movieDetailBloc.movieDetailStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return ShowMovieDetail(displayMovie: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () =>
                        _movieDetailBloc.fetchMovieDetail(widget.selectedMovie),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _movieDetailBloc.dispose();
    super.dispose();
  }
}

class ShowMovieDetail extends StatelessWidget {
  final Movie displayMovie;

  ShowMovieDetail({Key key, this.displayMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.network(
          'https://image.tmdb.org/t/p/w342${displayMovie.posterPath}',
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Hero(
                  tag: Text('anim_poster'),
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 400.0,
                      height: 400.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w342${displayMovie.posterPath}'),
                          fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(blurRadius: 20.0, offset: Offset(0.0, 10.0))
                      ],
                    ),
                  ),
                ),
                _filmDescription(displayMovie),
                Text(displayMovie.overview,
                    style: TextStyle(color: Colors.white, fontFamily: 'Arvo')),
                Padding(padding: const EdgeInsets.all(10.0)),
                RateFilmBottom(
                  displayMovie: displayMovie,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

Widget _filmDescription(Movie displayMovie) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
    child: Row(
      children: <Widget>[
        Expanded(
            child: Text(
          displayMovie.title,
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontFamily: 'Arvo'),
        )),
        Row(
          children: [
            Text(
              displayMovie.voteAverage.toStringAsFixed(2),
//                      '${widget.movie['vote_average']}/10',
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0, fontFamily: 'Arvo'),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.star, color: Colors.white),
          ],
        )
      ],
    ),
  );
}

class RateFilmBottom extends StatefulWidget {
  Movie displayMovie;

  RateFilmBottom({this.displayMovie});

  @override
  __RateFilmBottom createState() => __RateFilmBottom(displayMovie);
}

class __RateFilmBottom extends State<RateFilmBottom> {
  Movie displayMovie;

  __RateFilmBottom(this.displayMovie);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          width: 150.0,
          height: 60.0,
          alignment: Alignment.center,
          child: Text(
            'Rate Movie',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Arvo', fontSize: 20.0),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xaa3C3261)),
        )),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(7.0),
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                print("Item Clicked");
                Share.share('https://image.tmdb.org/t/p/w342${displayMovie.posterPath}',
                    subject: 'Great Film !');
              },
              icon: Icon(Icons.share),
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xaa3C3261)),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildBookmark(displayMovie)),
      ],
    );
  }

  Widget _buildBookmark(Movie movie) {
    var _alreadySaved = Common.movieId.contains(movie.id);

    print(_alreadySaved);
    return Container(
      padding: const EdgeInsets.all(7.0),
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {
          setState(() {
            if (_alreadySaved) {
              Common.movieId.remove(movie.id);
              Common.movieBookmarked.remove(movie);
              _alreadySaved = false;
            } else {
              Common.movieId.add(movie.id);
              Common.movieBookmarked.add(movie);
              _alreadySaved=true;
            }
            for(var item in Common.movieBookmarked){
              print(item.title);
            }
          });
        },
        icon: _alreadySaved
            ? Icon(Icons.bookmark, color: Colors.red)
            : Icon(Icons.bookmark, color: Colors.white),
        color: Colors.white,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xaa3C3261)),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;
  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.redAccent,
            child: Text(
              'Retry',
              style: TextStyle(),
            ),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}
