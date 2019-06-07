import 'package:flutter/material.dart';
import 'package:kib/pages/image_slider_page.dart';

import 'SlideRoute.dart';

class Router {
  static void navigateTo(page, BuildContext context) {
    Navigator.push(
      context,
      RouteTransition(
        widget: page,
        fade: true,
      ),
    );
  }

  static void push(page, BuildContext context) {
    Navigator.pushReplacement(
      context,
      RouteTransition(
        widget: page,
        fade: true,
      ),
    );
  }

  static void present(page, context) {
    Navigator.of(context).push(
      MaterialPageRoute(fullscreenDialog: true, builder: (context) => page),
    );
  }

  static void goToImageSlideshow(
      BuildContext context, List<String> images, int startingIndex) {
    Navigator.push(
      context,
      RouteTransition(
          widget: ImageSlideshowWidget(
              images: images, startingIndex: startingIndex),
          fade: false),
    );
  }
}
