import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lesson_7/models/tv_show.dart';
import 'package:lesson_7/networking/api_response.dart';
import 'package:lesson_7/view/movie_list.dart';
import 'package:lesson_7/blocs/tv_show_bloc.dart';
import 'package:lesson_7/view/movie_trending.dart';

class NavMenuDrawer extends StatefulWidget {
  @override
  _NavMenuDrawerState createState() => _NavMenuDrawerState();
}

class _NavMenuDrawerState extends State<NavMenuDrawer> {
  TvShowBloc _tvShowBloc;

  @override
  void initState() {
    _tvShowBloc = TvShowBloc();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Thuyen Pham',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Piazzolla',
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Image.asset('lib/assets/icons/profile.png',
                        height: 40, width: 40),
                  )
                ],
              ),
            )),
        ListTile(
          leading: Icon(Icons.airplay),
          title: Text('TV Shows'),
          onTap: () {
            Navigator.of(context).push(_NewPage(1));
          },
        ),
        ListTile(
          leading: Icon(Icons.stars),
          title: Text('Trending'),
          onTap: () {
            Navigator.of(context).push(_NewPage(2));
          },
        ),
        ListTile(
          leading: Icon(Icons.add_comment_outlined),
          title: Text('Reviews'),
          onTap: () {
            Navigator.of(context).push(_NewPage(3));
          },
        ),
        ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).push(_NewPage(4));
            }),
      ],
    );
  }
}

class _NewPage extends MaterialPageRoute<Null> {
  int id;

  _NewPage(this.id)
      : super(builder: (BuildContext context) {
          switch (id) {
            case 1:
              return MovieTrending();
              break;
            case 2:
              return Scaffold(
                appBar: AppBar(
                  title: Text('Screen $id'),
                ),
                body: Loading(
                  mesage: 'Trending  ...',
                ),
              );
              break;
            case 5:
              return Scaffold(
                appBar: AppBar(
                  title: Text('Screen $id'),
                ),
                body: Loading(
                  mesage: 'Trending  ...',
                ),
              );
              break;
            case 4:
              return Scaffold(
                appBar: AppBar(
                  title: Text('Screen $id'),
                ),
                body: Loading(
                  mesage: 'Trending  ...',
                ),
              );
              break;
          }
          return Container();
        });
}

class _newPage extends StatefulWidget {
  @override
  __newPageState createState() => __newPageState();
}

class __newPageState extends State<_newPage> {
  TvShowBloc _bloc;

  @override
  void initState() {
    _bloc = TvShowBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: RefreshIndicator(
        onRefresh: _bloc.fetchTvShowList(),
        child: StreamBuilder<ApiResponse<List<TvShow>>>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.ERROR:
                  return Error(
                    message: snapshot.data.message,
                    click: null,
                  );
                  break;
                case Status.LOADING:
                  return Loading(
                    mesage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return Complete(listShows: snapshot.data.data);
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  String mesage;

  Loading({Key key, this.mesage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Loading ...',
            style: TextStyle(color: Colors.green),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ],
      ),
    );
  }
}

class Error extends StatelessWidget {
  String message;
  Function clickError;

  Error({Key key, String message, Function click}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Error : $message'),
        ),
      ),
    );
  }
}

class Complete extends StatelessWidget {
  List<TvShow> listShows;

  Complete({Key key, this.listShows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Text('$listShows'),
      ),
    ));
  }
}
