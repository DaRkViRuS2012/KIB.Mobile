import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/widgets/service_widget.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);

  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<ServiceCard> services = [
    ServiceCard(
      index: 1,
    ),
    ServiceCard(
      index: 2,
    ),
    ServiceCard(
      index: 3,
    ),
    ServiceCard(
      index: 4,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Buy Insurance", context: context),
      body: Material(
        child: Container(
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
                children: services,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
