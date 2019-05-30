import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/models/media.dart';

class MediaPage extends StatefulWidget {
  final List<Media> images;
  MediaPage({this.images, Key key}) : super(key: key);

  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  List<Widget> getImageWidget() {
    var images = widget.images;
    int i = 0;
    List<Widget> list = [];
    images.forEach((image) {
      Widget a = InkWell(
        onTap: () {
          Router.goToImageSlideshow(
              context, images.map((image) => image.url), i);
        },
        child: Hero(
          tag: "$i",
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image.url), fit: BoxFit.fill)),
          ),
        ),
      );
      list.add(a);
      i++;
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Media", context: context),
      body: Material(
        child: Container(
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverGrid.count(
                // crossAxisSpacing: 10.0,
                // mainAxisSpacing: 10.0,
                crossAxisCount: 2,
                childAspectRatio: 1,
                children: getImageWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
