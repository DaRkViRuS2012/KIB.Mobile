import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/localized_text.dart';

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
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16.0),
                height: 100,
                child: Image(image: AssetImage('assets/images/Logo.png')),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, top: 64.0, right: 16.0),
                child: LocalizedText(
                  "about_us_content1",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: LocalizedText(
                  "about_us_content3",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
