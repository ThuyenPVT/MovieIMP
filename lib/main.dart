import 'package:flutter/material.dart';
import 'package:lesson_7/models/tv_show.dart';
import 'package:lesson_7/view/movie_detail.dart';
import 'package:lesson_7/view/movie_screen.dart';
import 'package:lesson_7/view/tv_show.dart';
import 'package:lesson_7/view/tv_show_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Route<dynamic> _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case MovieDetail.routeName:
        return _buildRoute(settings, MovieDetail(settings.arguments));
        break;
      case TvShowDetail.routeName:
        return _buildRoute(settings, TvShowDetail(settings.arguments));
        break;
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MovieScreen.routeName,
      onGenerateRoute: _getRoute,
      routes: {
        MovieScreen.routeName: (ctx) => MovieScreen(),
      },
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      debugShowCheckedModeBanner: false,
      title: 'API',
      home: MovieScreen(),
    );
  }
}
