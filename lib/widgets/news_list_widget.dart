import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kib/models/news.dart';
import 'package:kib/widgets/news_widget.dart';

class NewsListWidget extends StatefulWidget {
  final List<News> news;

  NewsListWidget({
    Key key,
    @required this.news,
  }) : super(key: key);

  @override
  MovieListWidgetState createState() {
    return new MovieListWidgetState();
  }
}

class MovieListWidgetState extends State<NewsListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 800),
        opacity: this.widget.news.isNotEmpty ? 1.0 : 0.0,
        child: ListView.builder(
            padding: EdgeInsets.only(bottom: 5, top: 5),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.news.length,
            itemBuilder: (BuildContext context, int index) {
              return NewsWidget(
                news: widget.news[index],
              );
            }),
      ),
    );
  }
}
