import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/widgets/service_widget.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({Key key}) : super(key: key);

  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
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

  List<String> categories = [
    "Health Insurance",
    "Life Insurance",
    "Cars Insurance"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Services", context: context),
      body: Material(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        child: Container(
                          // color: Colors.white,
                          // width: MediaQuery.of(context)
                          //         .size
                          //         .width /
                          //     1.5,
                          constraints: BoxConstraints.expand(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(category),
                          ),
                        ),
                        value: category,
                      );
                    }).toList(),
                    onChanged: (v) {
                      print(v);
                    },
                    value: categories[0],
                    hint: Text(
                      "Categories",
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: CustomScrollView(
                  primary: false,
                  slivers: <Widget>[
                    // DropdownButton<String>(
                    //   isExpanded: true,
                    //   items: categories.map((category) {
                    //     return DropdownMenuItem<String>(
                    //       child: Container(
                    //         color: Colors.white,
                    //         // width: MediaQuery.of(context)
                    //         //         .size
                    //         //         .width /
                    //         //     1.5,
                    //         constraints: BoxConstraints.expand(),
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Text(category),
                    //         ),
                    //       ),
                    //       value: category,
                    //     );
                    //   }).toList(),
                    //   onChanged: (v) {
                    //     print(v);
                    //   },
                    //   value: categories[0],
                    //   hint: Text(
                    //     "Categories",
                    //   ),
                    // ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
