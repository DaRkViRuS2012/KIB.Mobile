import 'package:flutter/material.dart';
import 'package:kib/common_widgets/localized_text.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/pages/about_us_page.dart';
import 'package:kib/pages/contact_us_page.dart';
import 'package:kib/pages/gallery_page.dart';
import 'package:kib/pages/news_page.dart';
import 'package:kib/pages/products_page.dart';
import 'package:kib/pages/services_page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../network.dart';
import 'styles.dart';

class RadialMenu extends StatefulWidget {
  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
    // ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key key, this.controller})
      : translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.elasticOut),
        ),
        scale = Tween<double>(
          begin: 1.50,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              1.0,
              curve: Curves.decelerate,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> rotation;
  final Animation<double> translation;
  final Animation<double> scale;

  goToPage(page, context) {
    _close();
    Future.delayed(const Duration(milliseconds: 1500), () {
      Router.navigateTo(page, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Transform.rotate(
              angle: radians(rotation.value),
              child: Container(
                width: 300.0,
                // color: Colors.red,
                child: Stack(
                    fit: StackFit.loose,
                    alignment: Alignment.center,
                    children: <Widget>[
                      _buildButton(
                        25,
                        color: Colors.red,
                        icon: FontAwesomeIcons.bong,
                        title: "news_title",
                        action: () {
                          goToPage(NewsPage(), context);
                        },
                      ),
                      _buildButton(90,
                          color: Colors.green,
                          icon: FontAwesomeIcons.bong,
                          title: "gallery_Title", action: () {
                        goToPage(GalleryPage(), context);
                      }),
                      _buildButton(155,
                          color: Colors.blue,
                          icon: FontAwesomeIcons.bong,
                          title: "about_us_title", action: () {
                        goToPage(AboutusPage(), context);
                        //launch(Network.baseUrl + '/aboutus');
                      }),
                      _buildButton(215,
                          color: Colors.black,
                          icon: FontAwesomeIcons.bong,
                          title: "contant_us_title", action: () {
                        goToPage(ContactusPage(), context);
                      }),
                      _buildButton(
                        330,
                        color: Colors.indigo,
                        icon: FontAwesomeIcons.bong,
                        title: "services_title",
                        action: () {
                          goToPage(ServicesPage(), context);
                        },
                      ),
                      _buildButton(
                        270,
                        color: Colors.orange,
                        icon: FontAwesomeIcons.bong,
                        title: "insurance_titl",
                        action: () {
                          goToPage(ProductsPage(), context);
                        },
                      ),
                      // _buildButton(270,
                      //     color: Colors.pink, icon: FontAwesomeIcons.bong),
                      // _buildButton(315,
                      //     color: Colors.yellow, icon: FontAwesomeIcons.bolt),
                      Transform.scale(
                        scale: scale.value - 1,
                        child: InkWell(
                          onTap: _close,
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/earth.png'),
                                    fit: BoxFit.contain)),
                          ),
                        ),
                      ),
                      Transform.scale(
                          scale: scale.value,
                          child: InkWell(
                            onTap: _open,
                            child: Hero(
                              child: Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/Logo.png'),
                                        fit: BoxFit.contain)),
                              ),
                              tag: "logo",
                            ),
                          )

                          // FloatingActionButton(
                          //     child: Icon(FontAwesomeIcons.solidDotCircle),
                          //     onPressed: _open),
                          )
                    ]),
              ));
        });
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }

  _buildButton(double angle,
      {Color color, IconData icon, String title = "", Function action}) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
            (translation.value) * cos(rad), (translation.value) * sin(rad)),
      child: GestureDetector(
        onTap: () {
          print("hello");
          action();
        },
        child: Container(
          decoration: BoxDecoration(
              border: new Border.all(color: Colors.grey),
              shape: BoxShape.circle),
          child: Container(
            alignment: Alignment(0, 0),
            margin: EdgeInsets.all(4.0),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle, gradient: Style.gradiantDecoration),
            child: LocalizedText(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
