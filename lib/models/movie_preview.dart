// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

class MoviePreview {
  int id;
  String key;
  String name;
  String type;

  MoviePreview({
    this.id,
    this.key,
    this.name,
    this.type,
  });

  MoviePreview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
    type = json['type'];
  }
}
