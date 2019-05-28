import 'package:flutter/material.dart';
import 'package:kib/bloc/appBloc.dart';
import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/models/service.dart';
import 'package:kib/models/service_responce.dart';
import 'package:kib/network.dart';
import 'package:kib/widgets/service_widget.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({Key key}) : super(key: key);

  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  static AppBloc appBloc;

  @override
  void initState() {
    // TODO: implement initState
    appBloc = AppBloc();
    appBloc.services();
    super.initState();
  }

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
                child: StreamBuilder<Service>(
                    stream: appBloc.selectedServiceStream,
                    builder: (context, serviceSnapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<ServiceResponce>(
                            //   stream: appBloc.servicesStream,
                            builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (!serviceSnapshot.hasData) {
                              var s = snapshot.data.data[0];
                              appBloc.subServices("${s.id}");
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
                                appBloc.subServices("${service.id}");
                              },
                              value: serviceSnapshot.hasData
                                  ? serviceSnapshot.data
                                  : snapshot.data
                                      .data[0], //"${snapshot.data.data[0].id}",
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
                child: StreamBuilder<ServiceResponce>(
                    stream: appBloc.subServicesStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomScrollView(
                          primary: false,
                          slivers: <Widget>[
                            SliverPadding(
                              padding: const EdgeInsets.all(20.0),
                              sliver: SliverGrid.count(
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                children: snapshot.data.data
                                    .map((service) => ServiceCard(
                                          service: service,
                                          baseURL: Network.mediaURL,
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
