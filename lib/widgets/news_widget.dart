import 'package:flutter/material.dart';
import 'package:kib/common_widgets/styles.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.8;
    return Container(
      margin: EdgeInsets.all(8.0),
      // width: 200,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [Style.shadow]),
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    image: AssetImage('assets/images/slider3.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "24/1/2019",
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "News Title",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
