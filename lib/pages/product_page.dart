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
import 'package:kib/network.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import '../localization.dart';
import 'auth/login_page.dart';

class ProdcutPage extends StatelessWidget {
  final baseURL;
  final index;
  final Service prodcut;

  const ProdcutPage({this.prodcut, this.baseURL, this.index, key})
      : super(key: key);

  viewPDF(link) {
    launch(link);
  }

  @override
  Widget build(BuildContext context) {
    print(prodcut.image(baseURL));
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      appBar: getAppBar(title: prodcut.enTitle, context: context),
      body: Material(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: TransitionToImage(
                    image: AdvancedNetworkImage(prodcut.image(baseURL),
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
                                tag: "${prodcut.id}",
                                child: Text(
                                  prodcut.title(
                                      AppLocalizations.of(context).locale),
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            subtitle: SingleChildScrollView(
                              child: Html(
                                data: prodcut.descritpion(
                                    AppLocalizations.of(context).locale),
                              ),
                            )
                            //  Text(
                            //   news.enBody,
                            //   style: TextStyle(fontSize: 16.0),
                            // ),
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
                        launch(Network.baseUrl +
                            '/application/' +
                            appBloc.token +
                            '/' +
                            "${appBloc.me.id}" +
                            '/create');
                        // Router.present(
                        //     ApplicationPage(
                        //       token: appBloc.token,
                        //       userId: "${appBloc.me.id}",
                        //     ),
                        //     context);
                      } else {
                        Router.present(LoginScreen(), context);
                      }
                    },
                    child: LocalizedText(
                      "buy_now",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
