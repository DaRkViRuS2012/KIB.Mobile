import 'package:flutter/material.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:kib/models/news.dart';
// import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kib/pages/news_single_page.dart';

import '../localization.dart';

class NewsWidget extends StatelessWidget {
  final News news;
  final double ratio;
  const NewsWidget({this.news, Key key, this.ratio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * ratio;
    return Material(
      child: InkWell(
        onTap: () {
          if (ratio != 1) {
            Router.present(NewsSinglePage(news: news), context);
          }
        },
        child: Container(
          margin: EdgeInsets.all(8.0),
          // width: 200,
          height: height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [Style.shadow]),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    image: DecorationImage(
                      image: NetworkImage(
                        news.image(),
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              news.createdAt.toIso8601String(),
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          ListTile(
                              title: Text(
                                news.title(AppLocalizations.of(context).locale),
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: SingleChildScrollView(
                                child: Html(
                                  data: news.body(
                                      AppLocalizations.of(context).locale),
                                ),
                              )
                              //  Text(
                              //   news.enBody,
                              //   style: TextStyle(fontSize: 16.0),
                              // ),
                              )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
