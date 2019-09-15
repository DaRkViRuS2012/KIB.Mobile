import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageSlideshowWidget extends StatefulWidget {
  final List<String> images;
  final int startingIndex;

  ImageSlideshowWidget({this.images, this.startingIndex});

  @override
  ImageSlideshowWidgetState createState() {
    return new ImageSlideshowWidgetState();
  }
}

class ImageSlideshowWidgetState extends State<ImageSlideshowWidget> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.startingIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: PageView.builder(
          controller: pageController,
          itemCount: widget.images.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            //index+1 to ignore first image as
            return Center(
              child: Hero(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.images[index]))),
                ),
                tag: "$index",
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('disposing slideshow');
  }
}
