import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:kib/models/service.dart';
import 'package:kib/pages/service_page.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

class ServiceCard extends StatefulWidget {
  final baseURL;
  final int index;
  final Service service;
  const ServiceCard({this.service, this.baseURL, this.index, Key key})
      : super(key: key);

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    var service = widget.service;
    print(service.image(widget.baseURL));
    return Material(
      child: InkWell(
        onTap: () {
          Router.navigateTo(
              ServicePage(
                service: service,
                baseURL: widget.baseURL,
              ),
              context);
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
                    child: TransitionToImage(
                      image: AdvancedNetworkImage(service.image(widget.baseURL),
                          timeoutDuration: Duration(minutes: 1)),
                      // This is the default placeholder widget at loading status,
                      // you can write your own widget with CustomPainter.
                      placeholder: Center(child: CircularProgressIndicator()),
                      // This is default duration
                      duration: Duration(milliseconds: 300),
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0)),
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: AssetImage('assets/images/slider3.jpg'),
                      // ),
                    ),
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
                            tag: "${service.id}",
                            child: Text(
                              service.enTitle,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          // subtitle: Text(
                          //   service.enDescription,
                          //   maxLines: 4,
                          // ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
