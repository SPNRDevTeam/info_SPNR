// news.dart is responsible for the news page

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

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
      separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 7, height: 7, color: Colors.grey),
      itemCount: news.length,
      shrinkWrap: true,
      itemBuilder: (context, int index) {
        print('article shown');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            displayImage(news[index]),
            Divider(
              thickness: 3,
              height: 3,
              color: Colors.grey
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(news[index].name, style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold))
              ),
            ),
            Divider(
              thickness: 3,
              height: 3,
              color: Colors.grey
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              child: ReadMoreText(
                '${news[index].description} ',
                trimCollapsedText: 'Развернуть', 
                trimExpandedText: 'Свернуть', 
                style: TextStyle(fontSize: 20, color: Colors.white), 
                moreStyle: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
                colorClickableText: Colors.grey,
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
          thickness: 7,
          height: 7, 
          color: Colors.grey,
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
