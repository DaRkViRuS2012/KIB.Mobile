import 'package:flutter/material.dart';
import 'package:kib/bloc/appBloc.dart';
import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/localized_text.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:kib/models/service.dart';

import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import '../localization.dart';
import '../network.dart';
import 'auth/login_page.dart';

class ServicePage extends StatelessWidget {
  final baseURL;
  final index;

  final Service service;
  const ServicePage({this.service, this.baseURL, this.index, key})
      : super(key: key);

  viewPDF(link) {
    launch(link);
  }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    print(service.image(baseURL));
    return Scaffold(
        appBar: getAppBar(title: service.enTitle, context: context),
        body: Material(
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: TransitionToImage(
                      image: AdvancedNetworkImage(service.image(baseURL),
                          timeoutDuration: Duration(minutes: 1)),
                      // This is the default placeholder widget at loading status,
                      // you can write your own widget with CustomPainter.
                      placeholder: Center(child: CircularProgressIndicator()),
                      // This is default duration
                      duration: Duration(milliseconds: 300),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          ListTile(
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              child: Hero(
                                tag: "${service.id}",
                                child: Text(
                                  service.title(
                                      AppLocalizations.of(context).locale),
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            subtitle: SingleChildScrollView(
                              child: HTMLWidget(
                                  data: service.descritpion(
                                      AppLocalizations.of(context).locale)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints.expand(height: 75),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 32.0, right: 32.0, bottom: 16.0),
                    child: FlatButton(
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Style.primaryDarkColor,
                      onPressed: () {
                        print("preseed");
                        if (appBloc.isUserLoggedIn) {
                          //  viewPDF(service.quotationURL(baseURL));
                          launch(Network.baseUrl +
                              '/application/service/' +
                              appBloc.token +
                              '/' +
                              "${appBloc.me.id}" +
                              '/create');
                        } else {
                          Router.present(LoginScreen(), context);
                        }
                      },
                      child: LocalizedText(
                        "get_qutation",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class HTMLWidget extends StatelessWidget {
  const HTMLWidget({
    Key key,
    @required this.data,
  }) : super(key: key);
  final String data;
  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      customTextAlign: (element) {
        var style = element.attributes["style"];
        if (style != null) {
          if (style.contains("text-align")) {
            if (style.contains("right")) {
              return TextAlign.right;
            }
          }
        }
        return TextAlign.left;
      },
    );
  }
}
