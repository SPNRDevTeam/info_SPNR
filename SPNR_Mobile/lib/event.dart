// event.dart is responsible for all event items and their pages

import 'main.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
    final parsedYearMonth = event.date.split('-');
    final year = parsedYearMonth[0];
    var month = parsedYearMonth[1];

    final parsedDayTime = parsedYearMonth[2].split(' ');
    final day = parsedDayTime[0];
    final time = parsedDayTime[1];
    final parsedTime = time.split(':');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Дата начала: $day.$month.$year', style: TextStyle(color: Colors.white, fontSize: 30)),
        Text('Время начала: ${parsedTime[0]}:${parsedTime[1]}', style: TextStyle(color: Colors.white, fontSize: 30))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(45, 47, 49, 1),
      appBar: AppBar(
        title: Text(event.name, style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: Color.fromRGBO(20, 22, 24, 1),
        iconTheme: IconThemeData(color: Colors.white, size: 25),  
      ),
      body: Column(
        children: [
          //displayImage(event.imgPath), // TODO: check with real urls to see if this works // TODO: add automatic resize
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              children: [
                
                printTimeOfEvent(event),
              ],
            ),
          )
        ],
      ),
    );
  }
}
