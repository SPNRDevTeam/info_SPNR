import 'dart:async';
import 'dart:convert';

import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Event>> fetchEvents(http.Client client) async { // fetches json and starts an isolated parsing of the events
  final response = await http.get(Uri.parse(
      'https://my-json-server.typicode.com/Evgen1987RUS/test-json/events/')); // TODO: тестовый джей сон поменять на нормальный

  return compute(parseEvents, response.body);
}

List<Event> parseEvents(String responseBody) { // decodes the json and casts into a map of strings
  final parsed = (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Event>((json) => Event.fromJson(json)).toList(); // maps the events and then turns them into lists (very complicated stuff, surprised this works)
}

class Event { // struct of an <Event> type objects
  final String id;
  final String name;
  final String description;
  final String date;
  final String imgPath;

  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.imgPath,
  });

  factory Event.fromJson(Map<String, dynamic> json) { // fetches json's variables and maps them to the <Event> object
    return Event(                                     // also possible to write with a newer implementation in .dart (pattern matching for json)
      id: json['id'] as String,                       // https://stackoverflow.com/questions/77554946/could-someone-explain-how-this-code-struct-in-dart-and-fetching-values-from-jso
      name: json['name'] as String,                   // this is the code + an explanation
      description: json['description'] as String,
      date: json['date'] as String,
      imgPath: json['imgPath'] as String,
    );
  }
}

void main() => runApp(const SPNRApp()); // main method which starts this app

class SPNRApp extends StatelessWidget { // class which point to the Home Page of the app
  const SPNRApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(title: 'Главная страница'),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key); // make it require the title as a key value
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(45, 47, 49, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 22, 24, 1),
        title: Text(title, style: TextStyle(fontSize: 25, color: Colors.white))
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15.0),
            color: Color.fromRGBO(33, 37, 41, 1),
            width: double.infinity,
            child: Text('Ближайшие мероприятия:', style: TextStyle(fontSize: 25 ,color: Colors.white)), // TODO: check if the scaling is off on ALL devices
          ),
          Container(
            color: Color.fromRGBO(33, 37, 41, 1),
            height: 400,
            child: SingleChildScrollView(
              child: FutureBuilder<List<Event>>(
                future: fetchEvents(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('line 83 snapshot failure');
                    return const Center(
                      child: Text('Ошибка'),
                    );
                  } else if (snapshot.hasData) {
                    return EventsList(events: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventsList extends StatelessWidget {
  const EventsList({super.key, required this.events});
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (context, int index) {
          print('displayed new event');
          return EventDescription(event: events[index]);
        });
  }
}

class EventDescription extends StatelessWidget {
  const EventDescription({super.key, required this.event});
  final Event event;

  Row timestamptzToText(Event event) {
    final parsedYearMonth = event.date.split('-');
    final year = parsedYearMonth[0];
    var month = parsedYearMonth[1];

    final parsedDayTime = parsedYearMonth[2].split(' ');
    final day = parsedDayTime[0];
    final time = parsedDayTime[1];

    switch (month) {
      case '01':
        month = 'ЯНВ';
      case '02':
        month = 'ФЕВ';
      case '03':
        month = 'МАР';
      case '04':
        month = 'АПР';
      case '05':
        month = 'МАЙ';
      case '06':
        month = 'ИЮН';
      case '07':
        month = 'ИЮЛ';
      case '08':
        month = 'АВГ';
      case '09':
        month = 'СЕН';
      case '10':
        month = 'ОКТ';
      case '11':
        month = 'НОЯ';
      case '12':
        month = 'ДЕК';
    }

    final parsedTime = time.split(':');

    return Row(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.0),
              alignment: Alignment.center,
              child: Text(
                day,
                style: TextStyle(fontSize: 40, color: Colors.red),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              alignment: Alignment.center,
              child: Text(
                month,
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
          ],
        ),
        
        RotatedBox(
          quarterTurns: 1,
          child: Text(
            parsedTime[0] + ':' + parsedTime[1],
            style: TextStyle(fontSize: 27, color: Colors.red),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          timestamptzToText(event),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(event.name, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold))
                ),
                Container(
                  height: 60,
                  width: 240,
                  child: Text(event.description, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis, maxLines: 3)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
