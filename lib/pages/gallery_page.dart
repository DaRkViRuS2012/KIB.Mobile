import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/router.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> images = [
    "assets/images/1.png",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/1.png",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/3.jpg",
    "assets/images/1.png",
    "assets/images/2.jpg",
  ];

  List<Widget> getImageWidget() {
    int i = 0;
    List<Widget> list = [];
    images.forEach((image) {
      Widget a = InkWell(
        onTap: () {
          Router.goToImageSlideshow(context, images, i);
        },
        child: Hero(
          tag: "$i",
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.fill)),
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
      appBar: getAppBar(title: "Gallery", context: context),
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
