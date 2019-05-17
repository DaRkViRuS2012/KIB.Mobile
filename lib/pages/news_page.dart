import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/widgets/news_widget.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "News", context: context),
      body: Material(
        child: Container(
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: 5, top: 5),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return NewsWidget();
              }),
        ),
      ),
    );
  }
}
