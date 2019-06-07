import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:kib/localization.dart';

var pageList = [
  FirstPageWdiget(
    imageUrl: "assets/images/slider1.png",
    title: "page1_title",
    body: "page1_body",
    titleGradient: gradients[0],
  ),
  SecondPageWdiget(
    imageUrl: "assets/images/slider2.png",
    title: "page2_title",
    body: "page2_body",
    titleGradient: gradients[1],
  ),
  ThirdPageWdiget(
    imageUrl: "assets/images/slider3.png",
    title: "page3_title",
    body: "page3_body",
    titleGradient: gradients[2],
  ),
];

List<List<Color>> gradients = [
  [Color(0xFF9708CC), Color(0xFF43CBFF)],
  [Color(0xFF9708CC), Color(0xFF43CBFF)],
  [Color(0xFF9708CC), Color(0xFF43CBFF)],
  [Color(0xFFE2859F), Color(0xFFFCCF31)],
  [Color(0xFF5EFCE8), Color(0xFF736EFE)],
];

class FirstPageWdiget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String body;

  final List<Color> titleGradient;

  FirstPageWdiget({
    Key key,
    this.imageUrl,
    this.title,
    this.body,
    this.titleGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 12.0),
            height: 100.0,
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: .10,
                  child: GradientText(
                    AppLocalizations.of(context).trans(title),
                    gradient: LinearGradient(
                      colors: [Color(0xFF9708CC), Color(0xFF43CBFF)],
                    ),
                    style: TextStyle(
                        fontSize: 100.0,
                        fontFamily: "Verdana",
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 22.0, top: 30),
                  child: GradientText(
                    AppLocalizations.of(context).trans(title),
                    gradient: LinearGradient(
                      colors: [Color(0xFF9708CC), Color(0xFF43CBFF)],
                    ),
                    style: TextStyle(
                        fontSize: 50.0,
                        fontFamily: "Verdana",
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 34.0, top: 16.0, end: 16),
            child: Transform(
              transform: Matrix4.translationValues(0, 0, 0),
              child: Text(
                AppLocalizations.of(context).trans(body),
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: "Verdana",
                    color: Colors.white //Color(0xFF9B9B9B),
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 34.0, top: 16.0, end: 16),
            child: Transform(
              transform: Matrix4.translationValues(0, 0, 0),
              child: Text(
                AppLocalizations.of(context).trans("slogan"),
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: "Verdana",
                    color: Colors.white //Color(0xFF9B9B9B),
                    ),
              ),
            ),
          )
          // "We Know How To Care"
        ],
      ),
    );
  }
}

class SecondPageWdiget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String body;

  final List<Color> titleGradient;

  const SecondPageWdiget(
      {Key key, this.imageUrl, this.title, this.body, this.titleGradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 12.0),
            height: 100.0,
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: .10,
                  child: GradientText(
                    AppLocalizations.of(context).trans(title),
                    gradient: LinearGradient(
                      colors: [Color(0xFF9708CC), Color(0xFF43CBFF)],
                    ),
                    style: TextStyle(
                        fontSize: 100.0,
                        fontFamily: "Verdana",
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 22.0, top: 30),
                  child: RichText(
                    text: TextSpan(
                        text: AppLocalizations.of(context).trans(title),
                        style: TextStyle(
                            color: Style.primaryDarkColor,
                            fontSize: 50.0,
                            fontFamily: "Verdana",
                            fontWeight: FontWeight.normal),
                        children: [
                          TextSpan(text: " "),
                          TextSpan(text: "K"),
                          TextSpan(
                              text: "I",
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                          TextSpan(text: "B")
                        ]),
                  ),
                  // GradientText(
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 34.0, top: 16.0, end: 16),
            child: Transform(
              transform: Matrix4.translationValues(0, 0, 0),
              child: Text(
                AppLocalizations.of(context).trans("resone1"),
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "Verdana",
                    color: Colors.white //Color(0xFF9B9B9B),
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 34.0, top: 16.0, end: 16),
            child: Transform(
              transform: Matrix4.translationValues(0, 0, 0),
              child: Text(
                AppLocalizations.of(context).trans("resone2"),
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "Verdana",
                    color: Colors.white //Color(0xFF9B9B9B),
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 34.0, top: 16.0, end: 16),
            child: Transform(
              transform: Matrix4.translationValues(0, 0, 0),
              child: Text(
                AppLocalizations.of(context).trans("resone3"),
                style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "Verdana",
                    color: Colors.white //Color(0xFF9B9B9B),
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ThirdPageWdiget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String body;
  final Widget child;
  final List<Color> titleGradient;

  const ThirdPageWdiget(
      {Key key,
      this.imageUrl,
      this.title,
      this.body,
      this.titleGradient,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 12.0),
            height: 100.0,
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: .10,
                  child: GradientText(
                    AppLocalizations.of(context).trans(title),
                    gradient: LinearGradient(
                      colors: [Color(0xFF9708CC), Color(0xFF43CBFF)],
                    ),
                    style: TextStyle(
                        fontSize: 100.0,
                        fontFamily: "Verdana",
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 22.0, top: 30),
                  child: GradientText(
                    AppLocalizations.of(context).trans(title),
                    gradient: LinearGradient(
                      colors: [Color(0xFF9708CC), Color(0xFF43CBFF)],
                    ),
                    style: TextStyle(
                        fontSize: 50.0,
                        fontFamily: "Verdana",
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 34.0, top: 16.0, end: 16),
            child: Transform(
              transform: Matrix4.translationValues(0, 0, 0),
              child: Text(
                AppLocalizations.of(context).trans(body),
                style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: "Verdana",
                    color: Colors.white //Color(0xFF9B9B9B),
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class PageModel {
//   final String imageUrl;
//   final String title;
//   final String body;
//   Widget child;

//   PageModel(
//       {this.imageUrl, this.title, this.body, this.titleGradient, this.child});
// }
