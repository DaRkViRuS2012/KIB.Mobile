import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/models/service.dart';
import 'package:kib/pages/product_page.dart';
import 'package:kib/pages/products_sons.dart';
import 'package:kib/widgets/service_widget.dart';
import 'package:kib/network.dart';

class InsuranceListWidget extends StatefulWidget {
  final List<Service> products;

  InsuranceListWidget({
    Key key,
    @required this.products,
  }) : super(key: key);

  @override
  InsuranceListWidgetState createState() {
    return new InsuranceListWidgetState();
  }
}

class InsuranceListWidgetState extends State<InsuranceListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 800),
        opacity: this.widget.products.isNotEmpty ? 1.0 : 0.0,
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
                children: widget.products
                    .map((product) => InkWell(
                        onTap: () {
                          Router.navigateTo(
                              ProductsSonsPage(
                                serviceId: "${product.id}",
                              ),
                              context);
                        },
                        child: ServiceCard(
                          service: product,
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
