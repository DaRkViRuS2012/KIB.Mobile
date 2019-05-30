import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kib/models/gallery.dart';
import 'package:kib/widgets/Gallery_widget.dart';

class GalleryListWidget extends StatefulWidget {
  final List<Gallery> galleries;

  GalleryListWidget({
    Key key,
    @required this.galleries,
  }) : super(key: key);

  @override
  MovieListWidgetState createState() {
    return new MovieListWidgetState();
  }
}

class MovieListWidgetState extends State<GalleryListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 800),
        opacity: this.widget.galleries.isNotEmpty ? 1.0 : 0.0,
        child: ListView.builder(
            padding: EdgeInsets.only(bottom: 5, top: 5),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.galleries.length,
            itemBuilder: (BuildContext context, int index) {
              return GalleryWidget(
                gallery: widget.galleries[index],
              );
            }),
      ),
    );
  }
}
