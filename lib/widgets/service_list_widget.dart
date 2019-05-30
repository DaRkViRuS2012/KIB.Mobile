import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kib/models/service.dart';
import 'package:kib/widgets/service_widget.dart';
import 'package:kib/network.dart';

class ServiceListWidget extends StatefulWidget {
  final List<Service> services;

  ServiceListWidget({
    Key key,
    @required this.services,
  }) : super(key: key);

  @override
  MovieListWidgetState createState() {
    return new MovieListWidgetState();
  }
}

class MovieListWidgetState extends State<ServiceListWidget> {
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
                    .map((service) => ServiceCard(
                          service: service,
                          baseURL: Network.mediaURL,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
