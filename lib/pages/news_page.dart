import 'package:flutter/material.dart';
import 'package:kib/bloc/appBloc.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/empty_result_widget.dart';
import 'package:kib/common_widgets/errors_widget.dart';
import 'package:kib/common_widgets/loading_widget.dart';
import 'package:kib/states/news_state.dart';
import 'package:kib/widgets/news_list_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  static AppBloc appBloc;
  @override
  void initState() {
    appBloc = AppBloc();
    appBloc.news();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "news_title", context: context),
      body: Material(
        child: Container(
          child: StreamBuilder(
              key: Key('streamBuilder'),
              stream: appBloc.newsStream,
              builder: (context, snapshot) {
                final data = snapshot.data;
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        key: Key('content'),
                        children: <Widget>[
                          // Fade in an Empty Result screen if the search contained
                          // no items
                          EmptyWidget(visible: data is NewsEmpty),

                          // Fade in a loading screen when results are being fetched
                          LoadingWidget(visible: data is NewsLoading),

                          // Fade in an error if something went wrong when fetching
                          // the results
                          ErrorsWidget(
                              visible: data is NewsError,
                              error: data is NewsError ? data.error : ""),

                          // Fade in the Result if available
                          NewsListWidget(
                              news: data is NewsPopulated ? data.news : []),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
