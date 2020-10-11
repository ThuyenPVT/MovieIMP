import 'package:flutter/material.dart';
import 'package:lesson_7/blocs/movie_bloc.dart';
import 'package:lesson_7/blocs/tv_show_bloc.dart';
import 'package:lesson_7/models/movie.dart';
import 'package:lesson_7/models/tv_show.dart';
import 'package:lesson_7/networking/api_response.dart';
import 'package:lesson_7/blocs/movie_bloc.dart';
import 'package:lesson_7/networking/api_response.dart';
import 'package:lesson_7/utils/Constant.dart';
import 'package:lesson_7/view/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:lesson_7/view/nav_menu_drawer.dart';
import 'package:lesson_7/view/tv_show_detail.dart';
import 'movie_bookmark.dart';

class TvShowPopular extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<TvShowPopular> {
  TvShowBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TvShowBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.bookmark),
        backgroundColor: Colors.red,
        onPressed: () {
          setState(() {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return ListTitle(
                    context,
                  );
                },
              ),
            );
          });
        },
      ),
      appBar: AppBar(
        actions: [
          Container(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                 print("Searching ...");
                },
                child: Icon(
                  Icons.search,
                ),
              )),
        ],
        elevation: 0.0,
        title: Text(
          'Top 10 TV Show',
          style: TextStyle(fontSize: 25, fontFamily: 'Piazzolla'),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchTvShowList(),
        child: StreamBuilder<ApiResponse<List<TvShow>>>(
          stream: _bloc.tvShowStream,
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
                    onRetryPressed: () => _bloc.fetchTvShowList(),
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
  final List<TvShow> movieList;

  const MovieList({Key key, this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        _buildTopThreeShows(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          alignment: Alignment.topLeft,
          child: Text(
            'Trending',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
          ),
        ),
        _buildTitleTopShows(),
        Expanded(
          child: SizedBox(
            height: 200.0,
            child: _buildTopShows(),
          ),
        )
      ],
    );
  }

  Widget _buildTopThreeShows() {
    movieList.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Baseline(
                      baselineType: TextBaseline.alphabetic,
                      baseline: 20,
                      child: Image.asset(
                        'lib/assets/icons/ic_rank_2.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  Image.network(
                    'https://image.tmdb.org/t/p/w342${movieList[1].posterPath}',
                    height: 60,
                    width: 60,
                  ),
                  Text(
                    '${movieList[1].originalName}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${movieList[1].voteAverage}'),
                        Icon(
                          Icons.star,
                          size: 15.0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${movieList[1].voteCount} vote'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Baseline(
                      baselineType: TextBaseline.alphabetic,
                      baseline: 15,
                      child: Image.asset(
                        'lib/assets/icons/ic_rank_1.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  Image.network(
                    'https://image.tmdb.org/t/p/w342${movieList[0].posterPath}',
                    height: 60,
                    width: 60,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '${movieList[0].originalName}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${movieList[0].voteAverage}'),
                      Icon(
                        Icons.star,
                        size: 15.0,
                      ),
                    ],
                  ),
                  Text('${movieList[0].voteCount} vote'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Baseline(
                      baselineType: TextBaseline.alphabetic,
                      baseline: 5,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset(
                            'lib/assets/icons/ic_rank_3.png',
                            height: 30,
                            width: 30,
                          ),
                          Text(
                            '3',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.network(
                    'https://image.tmdb.org/t/p/w342${movieList[2].posterPath}',
                    height: 60,
                    width: 60,
                  ),
                  Expanded(
                    child: Text(
                      '${movieList[2].originalName}',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${movieList[2].voteAverage}'),
                      Icon(
                        Icons.star,
                        size: 15.0,
                      ),
                    ],
                  ),
                  Text('${movieList[2].voteCount} vote'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleTopShows() {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(83, 120, 229, 2),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Rank',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            ),
          ),
          SizedBox(
            width: 70,
          ),
          Expanded(
            child: Text(
              'Film',
              style: TextStyle(color: Colors.white, fontSize: 13.0),
            ),
          ),
          Text(
            'Vote',
            style: TextStyle(color: Colors.white, fontSize: 13.0),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Rating',
            style: TextStyle(color: Colors.white, fontSize: 13.0),
          ),
        ],
      ),
    );
  }

  Widget _buildTopShows() {
    movieList.sort((a, b) => b.voteCount.compareTo(a.voteCount));
    return ListView.builder(
      itemCount: movieList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TvShowDetail((index + 2)),
                ),
              );
            },
            title: Row(
              children: [
                Container(
                  width: 23,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
                Image.network(
                  'https://image.tmdb.org/t/p/w342${movieList[index].posterPath}',
                  width: 80,
                  height: 50,
                  alignment: Alignment.center,
                ),
                Expanded(
                  child: Text('${movieList[index].originalName}'),
                ),
                Text(
                  '${movieList[index].voteCount}',
                  style: TextStyle(fontSize: 12.0, color: Colors.black38),
                ),
              ],
            ),
            trailing: Text('${movieList[index].voteAverage}'),
          ),
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
