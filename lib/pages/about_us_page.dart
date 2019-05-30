import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';

class AboutusPage extends StatefulWidget {
  AboutusPage({Key key}) : super(key: key);

  _AboutusPageState createState() => _AboutusPageState();
}

class _AboutusPageState extends State<AboutusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "about_us_title", context: context),
      body: Material(
        child: Container(child: Center(child: Text("Here gose About Us"))),
      ),
    );
  }
}
