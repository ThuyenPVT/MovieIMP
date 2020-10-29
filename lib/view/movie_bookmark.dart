import 'package:flutter/material.dart';
import 'package:lesson_7/models/movie.dart';
import 'package:lesson_7/shared/icon_styles.dart';
import 'package:lesson_7/shared/text_styles.dart';
import 'package:lesson_7/utils/Constant.dart';

class MovieBookmark extends StatefulWidget {
  static const String routeName = "/MovieBookmark";

  BuildContext context;

  MovieBookmark(this.context);

  @override
  _ListTitleState createState() => _ListTitleState(context);
}

class _ListTitleState extends State<MovieBookmark> {
  BuildContext context;

  _ListTitleState(this.context);

  @override
  Widget build(BuildContext context) {
    return _listTitle(context);
  }
}

Iterable<Container> _tiles() {
  return Constant.movieBookmarked.map(
    (Movie movie) {
      return Container(
          padding: EdgeInsets.all(5.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 3.0,
            child: ListTile(
              onTap: () {
                print("Clicked! ");
              },
              leading: Image.network(
                  'https://image.tmdb.org/t/p/w342${movie.posterPath}'),
              trailing: bookmarkIconRed,
              title: Text(
                movie.title,
                style: textFontPiazz20,
              ),
            ),
          ));
    },
  );
}

Widget _listTitle(BuildContext context) {
  final divided = ListTile.divideTiles(
    context: context,
    tiles: _tiles(),
  ).toList();

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Bookmark',
        style: textFontPiazz,
      ),
    ),
    body: ListView(children: divided),
  );
}
