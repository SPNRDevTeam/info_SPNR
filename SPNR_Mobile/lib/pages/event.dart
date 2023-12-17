// event.dart is responsible for all event items and their pages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Future<List<Event>> fetchEvents(http.Client client) async { // fetches json and starts an isolated parsing of the events
  final response = await http.get(Uri.parse('http://localhost:5150/Api/Events')); // TODO: тестовый джей сон поменять на нормальный

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
  final String dateTime;
  final String imgPath;

  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.imgPath,
  });

  factory Event.fromJson(Map<String, dynamic> json) { // fetches json's variables and maps them to the <Event> object
    return Event(                                     // also possible to write with a newer implementation in .dart (pattern matching for json)
      id: json['id'] as String,                       // https://stackoverflow.com/questions/77554946/could-someone-explain-how-this-code-struct-in-dart-and-fetching-values-from-jso
      name: json['name'] as String,                   // this is the code + an explanation
      description: json['description'] as String,
      dateTime: json['dateTime'] as String,
      imgPath: json['imgPath'] as String,
    );
  }
}

class EventDescription extends StatelessWidget { // the class of the item  in the event list
  const EventDescription({super.key, required this.event});
  final Event event;

  Row timestamptzToText(Event event) { // parsing the timestamptz data type from the database
    final yearMonthDay = event.dateTime.split('-');
    var month = yearMonthDay[1];
    final months = ['ЯНВ', 'ФЕВ', 'МАР', 'АПР', 'МАЙ', 'ИЮН', 'ИЮЛ', 'АВГ', 'СЕН', 'ОКТ', 'НОЯ', 'ДЕК'];
    month = months[int.parse(month) - 1];

    final parsedDayTime = yearMonthDay[2].split(' ');
    final day = parsedDayTime[0];
    final time = parsedDayTime[1];

    final parsedTime = time.split(':');

    return Row( // this displays the dateTime and time of the event
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
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage(event: event)));
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
                Text(event.name, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1),
                SizedBox(
                  height: 60,
                  width: width * 0.65,
                  child: Text(event.description, style: TextStyle(color: Colors.white, fontSize:  20), overflow: TextOverflow.ellipsis, maxLines: 2)
                ),
              ],
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
  Widget build(BuildContext context) { // creates the list of the events
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: events.length,
        shrinkWrap: true,
        itemBuilder: (context, int index) {
          print('item shown');
          return Container(
            child: EventDescription(event: events[index]), // this is the item that goes into the list
          );
        });
  }
}

class EventListBuilder extends StatelessWidget {
  const EventListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
        FutureBuilder<List<Event>>( // builds this widget in the future
          future: fetchEvents(http.Client()),
          builder: (context, snapshot) { // fetches snapshots
            if (snapshot.hasError) {
              print('snapshot failure');
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
        // FIXME: this is where the calendar is supposed to go
      ],
    );
  }
}

class EventPage extends StatelessWidget { // this is the widget class for the page that displays the event image, description, name, time etc.
  const EventPage({super.key, required this.event});
  final Event event;

  dynamic displayImage(String imgPath) {
    if (imgPath.isNotEmpty) {
      print('displayed an image');
      return Image.network(event.imgPath);
    } else {
      print('image fetch failure');
    }
  }

  Column printTimeOfEvent(Event event) {
    final yearMonthDay = event.dateTime.split('-');
    final year = yearMonthDay[0];
    var month = yearMonthDay[1];

    final parsedDayTime = yearMonthDay[2].split(' ');
    final day = parsedDayTime[0];
    final time = parsedDayTime[1];
    final parsedTime = time.split(':');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Дата начала: $day.$month.$year', style: TextStyle(color: Colors.white, fontSize: 20)),
        Text('Время начала: ${parsedTime[0]}:${parsedTime[1]}', style: TextStyle(color: Colors.white, fontSize: 20))
      ],
    );
  }

  @override
  Widget build(BuildContext context) { // diplays event information (event's card)
    return Scaffold(
      backgroundColor: Color.fromRGBO(45, 47, 49, 1),
      appBar: AppBar(
        title: Text(event.name, style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: Color.fromRGBO(20, 22, 24, 1),
        iconTheme: IconThemeData(color: Colors.white, size: 25),  
      ),
      body: ListView(
        children: [
            //displayImage(event.imgPath), // TODO: check with real urls to see if this works // TODO: add automatic resize
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: printTimeOfEvent(event),
            ),
            Divider( // TODO: change properties
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(event.description, style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
          ],
        ),
      );
  }
}
