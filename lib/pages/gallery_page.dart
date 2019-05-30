import 'package:flutter/material.dart';
import 'package:kib/bloc/appBloc.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/empty_result_widget.dart';
import 'package:kib/common_widgets/errors_widget.dart';
import 'package:kib/common_widgets/loading_widget.dart';
import 'package:kib/states/gallery_state.dart';
import 'package:kib/widgets/gallery_list_widget.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  static AppBloc appBloc;

  @override
  void initState() {
    appBloc = AppBloc();
    appBloc.galleries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "gallery_Title", context: context),
      body: Material(
        child: Container(
          child: StreamBuilder(
              key: Key('streamBuilder'),
              stream: appBloc.galleryStream,
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
                          EmptyWidget(visible: data is GalleryEmpty),

                          // Fade in a loading screen when results are being fetched
                          LoadingWidget(visible: data is GalleryLoading),

                          // Fade in an error if something went wrong when fetching
                          // the results
                          ErrorsWidget(
                              visible: data is GalleryError,
                              error: data is GalleryError ? data.error : ""),

                          // Fade in the Result if available
                          GalleryListWidget(
                              galleries: data is GalleryPopulated
                                  ? data.galleries
                                  : []),
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
