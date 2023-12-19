// news.dart is responsible for the news page

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../utilities.dart' as utils;

Future<List<NewsArticle>> fetchNews(http.Client client) async {
  final response = await http.get(Uri.parse('http://localhost:5150/Api/News'));

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
      id: json['id'] as String,                             // https://stackoverflow.com/questions/77554946/could-someone-explain-how-this-code-struct-in-dart-and-fetching-values-from-jso
      name: json['name'] as String,                         // this is the code + an explanation
      description: json['description'] as String,
      date: json['date'] as String,
      imgPath: json['imgPath'] as String,
    );
  }
}

class NewsListBuilder extends StatelessWidget {
  const NewsListBuilder({super.key, required this.news});
  final List<NewsArticle> news;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: news.length,
      shrinkWrap: true,
      itemBuilder: (context, int index) {
        print('article shown');
        return Column(
          children: [
            utils.displayImage(news[index]),
            Divider(),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(news[index].name, style: TextStyle(fontSize: 20, color: Colors.white))
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: SizedBox(
                height: 150, // TODO: look for appropriate height
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(news[index].description, style: TextStyle(fontSize: 20, color: Colors.white),),
              ),
            )
          ],
        );
      },
    );
  }
}

class NewsList extends StatelessWidget { // shows news on the page
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 15.0),
          color: Color.fromRGBO(33, 37, 41, 1),
          child: Text('Новости:', style: TextStyle(fontSize: 25 ,color: Colors.white)), 
        ),
        Divider(
          thickness: 2.0,
          color: Colors.grey, // TODO: change color
          height: 0,
        ),
        FutureBuilder(
          future: fetchNews(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Ошибка', style: TextStyle(fontSize: 25, color: Colors.white)),
              ); 
            } else if (snapshot.hasData) {
              return NewsListBuilder(news: snapshot.data!);
            } else {
              return Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
