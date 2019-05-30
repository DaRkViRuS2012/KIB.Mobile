import 'package:flutter/material.dart';
import 'package:kib/common_widgets/localized_text.dart';
import 'package:kib/common_widgets/radial_menu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Router.present(WelcomeSceen(), context);

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment(1, 1),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LocalizedText(
                    "welcome_msg",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LocalizedText(
                    "welcome_msg_sub_title",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: RadialMenu(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment(0, 0),
              child: LocalizedText(
                "rights_msg",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
