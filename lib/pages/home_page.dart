import 'package:flutter/material.dart';
import 'package:kib/common_widgets/onboard_screan.dart';
import 'package:kib/common_widgets/radial_menu.dart';
import 'package:kib/common_widgets/router.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  showModal(context) {
    final titleStyle = TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.w700,
    );

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async {
                return true;
              },
              child: WelcomeScreen());
        });
  }

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
                  child: Text(
                    "Welcome to KIB",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Choose what you want",
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
              child: Text(
                "All rights recieved to KIB @ 2019",
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
