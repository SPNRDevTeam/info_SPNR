// event.dart is responsible for all event items and their pages

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import '../utilities.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  _EventPageState({Key? key});
  Future<List<dynamic>> events = fetchData(http.Client(), 'Events');

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        events = fetchData(http.Client(), 'Events');
        setState((){});
      },
      child: EventListBuilder(events: events));
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
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              alignment: Alignment.center,
              child: Text(
                month,
                style: TextStyle(fontSize: 23, color: Colors.red),
              ),
            ),
          ],
        ),
        
        RotatedBox(
          quarterTurns: 1,
          child: Text(
            '${parsedTime[0]}:${parsedTime[1]}',
            style: TextStyle(fontSize: 34, color: Colors.red),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => EventPageOnPush(event: event)));
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
                SizedBox(
                  width: width * 0.65,
                  child: Text(event.name, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 2)),
                SizedBox(
                  width: width * 0.65,
                  height: 60,
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
  final List<dynamic> events;

  @override
  Widget build(BuildContext context) { // creates the list of the events
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: events.length,
      shrinkWrap: true,
      itemBuilder: (context, int index) {
        print('item shown');
        return Container( // even though this is highlighted as unnecessary use: this is very much necessary as the future builder will ignore the description without it being in a container 
          child: EventDescription(event: events[index]), // this is the item that goes into the list
        );
      });
  }
}

class EventListBuilder extends StatelessWidget {
  EventListBuilder({super.key, required this.events});
  final Future<List<dynamic>> events;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 15.0),
          color: Color.fromRGBO(33, 37, 41, 1),
          child: Text('Ближайшие мероприятия:', style: TextStyle(fontSize: 25 ,color: Colors.white)), // TODO: check if the scaling is off on ALL devices
        ),
        Divider(
          thickness: 2.0,
          color: Colors.grey, // TODO: change color
          height: 0,
        ),
        FutureBuilder<List<dynamic>>( // builds this widget in the future
          future: events,
          builder: (context, snapshot) { // fetches snapshots
            if (snapshot.hasError) {
              print('snapshot failure');
              return const Center(
                child: Text('Ошибка', style: TextStyle(fontSize: 25, color: Colors.white)),
              );
            } else if (snapshot.hasData) {
              return EventsList(events: snapshot.data!); // calls the class to create a list of all of the events
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

class EventPageOnPush extends StatelessWidget { // this is the widget class for the page that displays the event image, description, name, time etc.
  const EventPageOnPush({super.key, required this.event});
  final Event event;

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
            displayImage(event), // TODO: check with real urls to see if this works // TODO: add automatic resize
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: printTimeOfEvent(event),
            ),
            Divider( // TODO: change properties
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: HtmlWidget( // transforms html format to a flutter widget format
                event.text,
                textStyle: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      );
  }
}
