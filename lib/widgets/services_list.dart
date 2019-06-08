import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/localization.dart';
import 'package:kib/models/service.dart';
import 'package:kib/pages/service_page.dart';
import 'package:kib/pages/services_sons_page.dart';
import 'package:kib/widgets/service_widget.dart';
import 'package:kib/network.dart';

class ServiceList extends StatefulWidget {
  final List<Service> services;

  ServiceList({
    Key key,
    @required this.services,
  }) : super(key: key);

  @override
  ServiceListState createState() {
    return new ServiceListState();
  }
}

class ServiceListState extends State<ServiceList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 800),
        opacity: this.widget.services.isNotEmpty ? 1.0 : 0.0,
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                children: widget.services
                    .map(
                      (service) => InkWell(
                          onTap: () {
                            Router.navigateTo(
                                ServicesSonsPage(
                                  serviceId: "${service.id}",
                                ),
                                context);
                          },
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    child: Image(
                                      fit: BoxFit.scaleDown,
                                      image: NetworkImage(Network.mediaURL +
                                          '/${service.icon}'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment(0, 0),
                                    color: Colors.white,
                                    child: Text(
                                      service.title(
                                          AppLocalizations.of(context).locale),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
