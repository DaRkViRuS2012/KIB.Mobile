import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';

class ContactusPage extends StatefulWidget {
  ContactusPage({Key key}) : super(key: key);

  _ContactusPageState createState() => _ContactusPageState();
}

class _ContactusPageState extends State<ContactusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Contact us", context: context),
      body: Material(
        child: Container(
          child: Center(
            child: Text("Here gose Contact Us"),
          ),
        ),
      ),
    );
  }
}
