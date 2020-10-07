import 'package:flutter/material.dart';
import 'package:lesson_7/view/movie_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      debugShowCheckedModeBanner: false,
      title: 'API',
      home: MovieScreen(),
    );
  }
}
