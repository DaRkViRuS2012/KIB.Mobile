import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:kib/pages/service_page.dart';

class ServiceCard extends StatefulWidget {
  final int index;
  const ServiceCard({this.index, Key key}) : super(key: key);

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Router.navigateTo(ServicePage(), context);
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [Style.shadow],
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white),
        // height: 300.0,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/slider3.jpg'))),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Hero(
                          tag: "${widget.index}",
                          child: Text(
                            "Service Title",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Text(
                          "Some Info About Service Some Info About Service Some Info About Service",
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
