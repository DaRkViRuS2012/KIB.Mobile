import 'package:flutter/material.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:kib/models/gallery.dart';
import 'package:kib/pages/media_page.dart';

class GalleryWidget extends StatelessWidget {
  final Gallery gallery;
  const GalleryWidget({this.gallery, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.4;
    return InkWell(
      onTap: () {
        print("tapped");
        Router.navigateTo(
            MediaPage(
              images: gallery.media,
            ),
            context);
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
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    image: DecorationImage(
                      image: NetworkImage(gallery.image()),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          gallery.enTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
