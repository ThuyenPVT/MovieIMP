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
import 'movie_bookmark.dart';

class MovieTrending extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieTrending> {
  TvShowBloc _bloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _bloc = TvShowBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: NavMenuDrawer(),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
          icon: Icon(Icons.menu, color: Colors.white),
        ),
        actions: [
          Container(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
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
                child: Icon(
                  Icons.bookmark,
                ),
              )),
        ],
        elevation: 0.0,
        title: Text(
          'Phim Hay',
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
                print('Clicked trending !');
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => MovieDetail(movieList[index].id)));
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