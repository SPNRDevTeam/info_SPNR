// this is the main file that is responsible for the home page of the mobile app
// as well as fetching all of the events from the json provided

import 'dart:async';
import 'dart:convert';
import 'event.dart' as event_file;

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
      home: const MainPage(title: 'Главная страница'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState(title: title);
}


class _MainPageState extends State<MainPage> { // Home Page widget
  _MainPageState({Key? key, required this.title}); // make it require the title as a key value
  final String title;                                                // this is so we can define what page this is
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(45, 47, 49, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 22, 24, 1),
        title: Text(title, style: TextStyle(fontSize: 25, color: Colors.white))
      ),
      body: ListView(
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 15.0),
            color: Color.fromRGBO(33, 37, 41, 1),
            width: double.infinity,
            child: Text('Ближайшие мероприятия:', style: TextStyle(fontSize: 25 ,color: Colors.white)), // TODO: check if the scaling is off on ALL devices
          ),
          Divider(
            thickness: 2.0,
            color: Colors.grey, // TODO: change color
            height: 0,
          ),
          Container(
            color: Color.fromRGBO(33, 37, 41, 1),
            height: 400,
            child: SingleChildScrollView( // this is to create a scroll box for the events
              child: FutureBuilder<List<Event>>( // builds this widget in the future
                future: fetchEvents(http.Client()),
                builder: (context, snapshot) { // fetches snapshots
                  if (snapshot.hasError) {
                    print('line 83 snapshot failure');
                    return const Center(
                      child: Text('Ошибка', style: TextStyle(fontSize: 25, color: Colors.white)),
                    );
                  } else if (snapshot.hasData) {
                    return EventsList(events: snapshot.data!); // calls the class to create a list of all of the events
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          // FIXME: this is where the calendar is supposed to go
        ],
      ),
    bottomNavigationBar: BottomNavigationBar(
      onTap: (int index) {
        setState(() {
          currentPage = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color.fromRGBO(20, 22, 24, 1),
      selectedItemColor: Colors.white,
      currentIndex: 0,
      items: [
        BottomNavigationBarItem( // home page
          icon: Icon(Icons.home_outlined),
          label: 'Главная',
        ),
        BottomNavigationBarItem( // 
          icon: Icon(Icons.favorite),
          label: 'Избранное',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.archive),
          label: 'Архив',
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
  Widget build(BuildContext context) { // creates the list of the events
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (context, int index) {
          print('displayed new event');
          return EventDescription(event: events[index]); // this is the item that goes into the list
        });
  }
}

class EventDescription extends StatelessWidget { // the class of the item  in the event list
  const EventDescription({super.key, required this.event});
  final Event event;

  Row timestamptzToText(Event event) { // parsing the timestamptz data type from the database
    final parsedYearMonth = event.date.split('-');
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

    return Row( // this displays the date and time of the event
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
            '${parsedTime[0]}:${parsedTime[1]}',
            style: TextStyle(fontSize: 27, color: Colors.red),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) { // all items in the event list are made here
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => event_file.EventPage(event: event)));
      },
      child: Row(
        children: <Widget>[
          timestamptzToText(event), // time of the event
          Container( // title of the event and short description
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.name, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1),
                SizedBox(
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

