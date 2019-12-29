import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:kib/models/news.dart';
import 'package:kib/pages/service_page.dart';
import '../localization.dart';

class NewsSinglePage extends StatelessWidget {
  final News news;
  const NewsSinglePage({this.news, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          title: news.title(AppLocalizations.of(context).locale),
          context: context),
      body: Material(
        child: Container(
          // margin: EdgeInsets.all(8.0),
          // width: 200,
          // height: height,
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
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: HTMLWidget(
                              data: news
                                  .body(AppLocalizations.of(context).locale),
                            ),
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
