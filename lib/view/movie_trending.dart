import 'package:flutter/material.dart';
import 'package:lesson_7/blocs/movie_trending_bloc.dart';
import 'package:lesson_7/models/movie_trending.dart';
import 'package:lesson_7/networking/api_response.dart';
import 'package:lesson_7/shared/icon_styles.dart';
import 'package:lesson_7/shared/text_styles.dart';
import 'package:lesson_7/view/movie_detail.dart';
import 'movie_bookmark.dart';

class MovieTrendingScreen extends StatefulWidget {
  static const String routeName = "/TopMovieTrending";

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieTrendingScreen> {
  MovieTrendingBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MovieTrendingBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return MovieBookmark(
                            context,
                          );
                        },
                      ),
                    );
                  });
                },
                child: bookmarkIcon,
              )),
        ],
        elevation: 0.0,
        title: Text(
          'Top 10 Trending Film',
          style: textFont25,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchMovieTrendingList(),
        child: StreamBuilder<ApiResponse<List<MovieTrending>>>(
          stream: _bloc.movieTrendingStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return MovieList(movieList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchMovieTrendingList(),
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
    _bloc.dispose();
    super.dispose();
  }
}

class MovieList extends StatelessWidget {
  final List<MovieTrending> movieList;

  const MovieList({Key key, this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 1.8,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () {
                // Route _detailMovieRoute = MaterialPageRoute(
                //     builder: (context) => MovieDetail(movieList[index].id));
                // Navigator.of(context).push(_detailMovieRoute);
                Navigator.pushNamed(context, MovieDetail.routeName,
                    arguments: movieList[index].id);
              },
              child: GestureDetector(
                child: Card(
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Hero(
                        tag: Text('anim_poster'),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w342${movieList[index].posterPath}',
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
              )),
        );
      },
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
            style: textFont18,
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.redAccent,
            child: Text(
              'Retry',
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
            style: textFont24,
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
