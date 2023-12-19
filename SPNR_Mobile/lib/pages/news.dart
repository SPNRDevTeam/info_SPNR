// news.dart is responsible for the news page

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utilities.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  _NewsPageState({Key? key});
  Future<List<dynamic>> news = fetchData(http.Client(), 'News');

  @override
  build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        news = fetchData(http.Client(), 'News');
        setState((){});
      },
      child: NewsList(news: news),
    );
  }
}

class NewsListBuilder extends StatelessWidget {
  const NewsListBuilder({super.key, required this.news});
  final List<dynamic> news;

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
            displayImage(news[index]),
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
  const NewsList({super.key, required this.news});
  final Future<List<dynamic>> news;

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
          future: fetchData(http.Client(), 'News'),
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
