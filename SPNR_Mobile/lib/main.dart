// this is the main file that is responsible for the home page of the mobile app
// as well as fetching all of the events from the json provided

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'pages/event.dart' as event;
import 'pages/news.dart' as news;


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
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {     // App class
  _MainPageState({Key? key});
  int _currentPage = 0;
  
  static List<Widget> _pages = [
    event.EventPage(),
    news.NewsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(45, 47, 49, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 22, 24, 1),
        title: Text('СПНР', style: TextStyle(fontSize: 25, color: Colors.white))
      ),
      body: _pages.elementAt(_currentPage),
      bottomNavigationBar: BottomNavigationBar( // navbar at the bottom
        onTap: (int index) { // sets the page that we want to see
          setState(() {
            _currentPage = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(20, 22, 24, 1),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: _currentPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        items: [
          BottomNavigationBarItem( // home page
            icon: Icon(Icons.home_outlined),
            label: 'Главная',
          ),
          /* 
          // event calendar: future addition in case of working on this porject later
          // will show a table calendar with all of the events marked.
          BottomNavigationBarItem( // calendar
            icon: Icon(Icons.calendar_month),
            label: 'Календарь', 
          ),
          */
          /* 
          // favorites: future addition in case of working on this porject later
          // will allow a person to favorite events and get push notifications only for them.
          BottomNavigationBarItem( // favorited events
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          */
          BottomNavigationBarItem( // news
            icon: Icon(Icons.newspaper),
            label: 'Новости',
          ),
          BottomNavigationBarItem( // media and contact info
            icon: FaIcon(FontAwesomeIcons.bullhorn),
            label: 'Контакты',
          ),
        ],
      ),  
    );
  }
}
