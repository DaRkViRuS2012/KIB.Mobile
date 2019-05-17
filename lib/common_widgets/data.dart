import 'package:flutter/material.dart';

var pageList = [
  PageModel(
      imageUrl: "assets/images/slider1.png",
      title: "Welcom",
      body: "TO KHOURY INSURANCE BROKER",
      titleGradient: gradients[0]),
  PageModel(
      imageUrl: "assets/images/slider2.png",
      title: "Why KIB",
      body: "FEEL THE MAGIC OF WELLNESS",
      titleGradient: gradients[1]),
  PageModel(
      imageUrl: "assets/images/slider4.png",
      title: "Insurance",
      body: "JUST IN YOUR HAND",
      titleGradient: gradients[2]),
];

List<List<Color>> gradients = [
  [Color(0xFF9708CC), Color(0xFF43CBFF)],
  [Color(0xFF9708CC), Color(0xFF43CBFF)],
  [Color(0xFF9708CC), Color(0xFF43CBFF)],
  [Color(0xFFE2859F), Color(0xFFFCCF31)],
  [Color(0xFF5EFCE8), Color(0xFF736EFE)],
];

class PageModel {
  var imageUrl;
  var title;
  var body;
  List<Color> titleGradient = [];
  PageModel({this.imageUrl, this.title, this.body, this.titleGradient});
}
