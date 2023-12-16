// news.dart is responsible for the news page

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<NewsArticle>> fetchNews(http.Client client) async {
  final response = await http.get(Uri.parse('https://my-json-server.typicode.com/Evgen1987RUS/test-json/events/'));

  return compute(parseNews, response.body);
}

List<NewsArticle> parseNews(String responseBody) {
  final parsed = (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>(); // decodes the json and casts into a map of strings

  return parsed.map<NewsArticle>((json) => NewsArticle.fromJson(json)).toList();
}

class NewsArticle {
  final String id;
  final String name;
  final String description;
  final String date;
  final String imgPath;

  const NewsArticle({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.imgPath,
  });
// TODO: change to whatever data I am pulling from the JSON
  factory NewsArticle.fromJson(Map<String, dynamic> json) { // fetches json's variables and maps them to the <Event> object
    return NewsArticle(                                     // also possible to write with a newer implementation in .dart (pattern matching for json)
      id: json['id'] as String,                       // https://stackoverflow.com/questions/77554946/could-someone-explain-how-this-code-struct-in-dart-and-fetching-values-from-jso
      name: json['name'] as String,                   // this is the code + an explanation
      description: json['description'] as String,
      date: json['date'] as String,
      imgPath: json['imgPath'] as String,
    );
  }
}
