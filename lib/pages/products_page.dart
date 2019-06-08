import 'package:flutter/material.dart';
import 'package:kib/bloc/appBloc.dart';
import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/empty_result_widget.dart';
import 'package:kib/common_widgets/errors_widget.dart';
import 'package:kib/common_widgets/loading_widget.dart';
import 'package:kib/models/service.dart';
import 'package:kib/models/service_responce.dart';
import 'package:kib/states/service_state.dart';
import 'package:kib/widgets/insurance_list.dart';
import 'package:kib/widgets/product_list.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);

  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  static AppBloc appBloc;
  bool firstTime = true;

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    appBloc.mainProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "buy_Insurance", context: context),
      body: Material(
        child: Container(
          child: StreamBuilder<bool>(
              stream: appBloc.loadingStream,
              builder: (context, loadingSnapshot) {
                return Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          flex: 8,
                          child: StreamBuilder(
                              key: Key('streamBuilder'),
                              stream: appBloc.insurancesStream,
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
                                          EmptyWidget(
                                              visible: data is ServicesEmpty),

                                          // Fade in a loading screen when results are being fetched
                                          LoadingWidget(
                                              visible: data is ServicesLoading),

                                          // Fade in an error if something went wrong when fetching
                                          // the results
                                          ErrorsWidget(
                                              visible: data is ServicesError,
                                              error: data is ServicesError
                                                  ? data.error
                                                  : ""),

                                          // Fade in the Result if available
                                          InsuranceListWidget(
                                              products:
                                                  data is ServicesPopulated
                                                      ? data.services
                                                          .where((i) =>
                                                              i.parentId == 0)
                                                          .toList()
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
                    loadingSnapshot.hasData
                        ? loadingSnapshot.data
                            ? LoadingWidget(
                                visible: true,
                              )
                            : Container()
                        : Container()
                  ],
                );
              }),
        ),
      ),
    );
  }
}
