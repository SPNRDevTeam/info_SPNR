import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Event>> fetchEvents(http.Client client) async {
  final response = await http.get(Uri.parse(
      'https://my-json-server.typicode.com/Evgen1987RUS/test-json/events/')); // TODO: тестовый джей сон поменять на нормальный

  return compute(parseEvents, response.body);
}

List<Event> parseEvents(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Event>((json) => Event.fromJson(json)).toList();
}

class Event {
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

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      imgPath: json['imgPath'] as String,
    );
  }
}

void main() => runApp(const SPNRApp());

class SPNRApp extends StatelessWidget {
  const SPNRApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'СПНР',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const HomePage(title: 'Главная страница'),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title})
      : super(key: key); // make it require the title as a key value
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        color: Colors.black,
        height: 100,
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

    return Row(
      children: [
        Column(
          children: [
            Text(
              day,
              style: TextStyle(fontSize: 40, color: Colors.red),
            ),
            Text(
              month,
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ],
        ),
        Text(
          time, // TODO: check to see if this works all right
          style: TextStyle(fontSize: 20),
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
          Column(
            children: [
              Text(event.name),
              Text(event.description),
            ],
          ),
        ],
      ),
    );
  }
}
