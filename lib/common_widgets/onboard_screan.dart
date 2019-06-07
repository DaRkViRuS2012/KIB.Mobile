import 'package:flutter/material.dart';
import 'package:kib/common_widgets/data.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:kib/localization.dart';
import 'package:kib/pages/home_page.dart';
import 'Page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => new _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  PageController _controller;
  int currentPage = 0;
  bool lastPage = false;
  AnimationController animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
    );
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textDirction = AppLocalizations.of(context).locale.languageCode == "ar"
        ? TextDirection.rtl
        : TextDirection.ltr;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Style.primaryLightColor, Style.primaryDarkColor],
          tileMode: TileMode.clamp,
          begin: Alignment.topCenter,
          stops: [0.0, 1.0],
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PageView.builder(
              itemCount: pageList.length,
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  if (currentPage == pageList.length - 1) {
                    lastPage = true;
                    animationController.forward();
                  } else {
                    lastPage = false;
                    animationController.reset();
                  }
                  print(lastPage);
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/slider" + "${index + 1}" + ".png"),
                          fit: BoxFit.cover)),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      var page = pageList[index];
                      var delta;
                      var y = 1.0;

                      if (_controller.position.haveDimensions) {
                        delta = _controller.page - index;
                        y = 1 - delta.abs().clamp(0.0, 1.0);
                      }
                      return page;
                    },
                  ),
                );
              },
            ),
            Positioned.directional(
              textDirection: textDirction,
              start: 30.0,
              bottom: 55.0,
              child: Container(
                  width: 100.0,
                  child: PageIndicator(currentPage, pageList.length)),
            ),
            Positioned.directional(
              textDirection: textDirction,
              end: 30.0,
              bottom: 30.0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: lastPage
                    ? FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Router.navigateTo(MyHomePage(), context);
                        },
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
