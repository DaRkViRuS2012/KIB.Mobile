import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/models/news.dart';
import 'package:kib/pages/news_single_page.dart';
import 'package:kib/widgets/news_widget.dart';

class NewsListWidget extends StatefulWidget {
  final List<News> news;

  NewsListWidget({
    Key key,
    @required this.news,
  }) : super(key: key);

  @override
  NewsListWidgetState createState() {
    return new NewsListWidgetState();
  }
}

class NewsListWidgetState extends State<NewsListWidget> {
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
              return InkWell(
                onTap: () {
                  Router.push(
                      NewsSinglePage(news: widget.news[index]), context);
                },
                child: NewsWidget(
                  news: widget.news[index],
                  ratio: 0.8,
                ),
              );
            }),
      ),
    );
  }
}
