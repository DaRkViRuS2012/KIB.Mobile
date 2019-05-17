import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/styles.dart';

class ServicePage extends StatelessWidget {
  final index;
  const ServicePage({this.index, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(title: "Services Title", context: context),
        body: Material(
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/slider3.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                          child: Hero(
                            tag: "$index",
                            child: Text(
                              "Service Title",
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        subtitle: Text(
                          "Some Info About Service Some Info About Service Some Info About Service Some Info About Service Some Info About Service Some Info About Service Some Info About Service Some Info About Service Some Info About Service Some Info About Service Some Info About Service Some Info About Service",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints.expand(height: 75),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 32.0, right: 32.0, bottom: 16.0),
                    child: FlatButton(
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Style.primaryDarkColor,
                      onPressed: () {
                        print("preseed");
                      },
                      child: Text(
                        "Get Qoutation",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
