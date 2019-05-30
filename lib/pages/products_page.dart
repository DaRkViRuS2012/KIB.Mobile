import 'package:flutter/material.dart';
import 'package:kib/bloc/appBloc.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/empty_result_widget.dart';
import 'package:kib/common_widgets/errors_widget.dart';
import 'package:kib/common_widgets/loading_widget.dart';
import 'package:kib/models/service.dart';
import 'package:kib/models/service_responce.dart';
import 'package:kib/states/service_state.dart';
import 'package:kib/widgets/service_list_widget.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);

  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  static AppBloc appBloc;
  bool firstTime = true;

  @override
  void initState() {
    appBloc = AppBloc();
    appBloc.mainProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "buy_Insurance", context: context),
      body: Material(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: StreamBuilder<Service>(
                    stream: appBloc.selectedServiceStream,
                    builder: (context, serviceSnapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<ServiceResponce>(
                            stream: appBloc.insurancesStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (!serviceSnapshot.hasData && firstTime) {
                                  firstTime = false;
                                  var s = snapshot.data.data[0];
                                  appBloc.services("${s.id}");
                                }
                                return DropdownButton<Service>(
                                  isExpanded: true,
                                  items: snapshot.data.data
                                      .where((i) => i.parentId == 0)
                                      .map((service) {
                                    return DropdownMenuItem<Service>(
                                      child: Container(
                                        // color: Colors.white,
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     1.5,
                                        constraints: BoxConstraints.expand(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(service.enTitle),
                                        ),
                                      ),
                                      value: service, //"${service.id}",
                                    );
                                  }).toList(),
                                  onChanged: (service) {
                                    print(service);
                                    appBloc.changeService(service);
                                    appBloc.services("${service.id}");
                                  },
                                  value: serviceSnapshot.hasData
                                      ? serviceSnapshot.data
                                      : snapshot.data.data[
                                          0], //"${snapshot.data.data[0].id}",
                                  hint: Text(
                                    "Categories",
                                  ),
                                );
                              }
                              return Container();
                            }),
                      );
                    }),
              ),
              Expanded(
                flex: 8,
                child: StreamBuilder(
                    key: Key('streamBuilder'),
                    stream: appBloc.productsStream,
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: Stack(
                              key: Key('content'),
                              children: <Widget>[
                                // Fade in an Empty Result screen if the search contained
                                // no items
                                EmptyWidget(visible: data is ServicesEmpty),

                                // Fade in a loading screen when results are being fetched
                                LoadingWidget(visible: data is ServicesLoading),

                                // Fade in an error if something went wrong when fetching
                                // the results
                                ErrorsWidget(
                                    visible: data is ServicesError,
                                    error: data is ServicesError
                                        ? data.error
                                        : ""),

                                // Fade in the Result if available
                                ServiceListWidget(
                                    services: data is ServicesPopulated
                                        ? data.services
                                        : []),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
