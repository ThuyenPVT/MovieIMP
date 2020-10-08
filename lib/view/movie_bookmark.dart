import 'package:flutter/material.dart';
import 'package:lesson_7/models/movie.dart';
import 'package:lesson_7/utils/Constant.dart';

class ListTitle extends StatefulWidget {
  BuildContext context;
  ListTitle(this.context);
  @override
  _ListTitleState createState() => _ListTitleState(context);
}

class _ListTitleState extends State<ListTitle> {
  BuildContext context;
  _ListTitleState(this.context);
  @override
  Widget build(BuildContext context) {
    return _listTitle(context);
  }
}

Iterable<Container> _tiles() {
  return Common.movieBookmarked.map(
    (Movie movie) {
      return Container(
          padding: EdgeInsets.all(5.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 3.0,
            child: ListTile(
              onTap: (){
                print("Clicked! ");
              },
              leading: Card(
                child: Image.network(
                    'https://image.tmdb.org/t/p/w342${movie.posterPath}'),
              ),
              trailing: Icon(Icons.bookmark, color: Colors.red),
              title: Text(
                movie.title,style: TextStyle(fontFamily: 'Piazzolla',fontSize:20.0),
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
        style: TextStyle(fontFamily: 'Piazzolla'),
      ),
    ),
    body: ListView(children: divided),
  );
}
