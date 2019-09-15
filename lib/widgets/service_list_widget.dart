import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/models/service.dart';
import 'package:kib/pages/service_page.dart';
import 'package:kib/widgets/service_widget.dart';
import 'package:kib/network.dart';

class ServiceListWidget extends StatefulWidget {
  final List<Service> services;

  ServiceListWidget({
    Key key,
    @required this.services,
  }) : super(key: key);

  @override
  ServiceListWidgetState createState() {
    return new ServiceListWidgetState();
  }
}

class ServiceListWidgetState extends State<ServiceListWidget> {
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
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                children: widget.services
                    .map((service) => InkWell(
                        onTap: () {
                          Router.navigateTo(
                              ServicePage(
                                service: service,
                              ),
                              context);
                        },
                        child: ServiceCard(
                          service: service,
                          baseURL: Network.mediaURL,
                        )))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
