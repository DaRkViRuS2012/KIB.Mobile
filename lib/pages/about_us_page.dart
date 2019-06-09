import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kib/bloc/appBloc.dart';
import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/localized_text.dart';
import 'package:kib/models/about_response.dart';

import '../localization.dart';

class AboutusPage extends StatefulWidget {
  AboutusPage({Key key}) : super(key: key);

  _AboutusPageState createState() => _AboutusPageState();
}

class _AboutusPageState extends State<AboutusPage> {
  AppBloc appBloc;
  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    appBloc.aboutus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "about_us_title", context: context),
      body: Material(
        child: StreamBuilder<AboutResponce>(
            stream: appBloc.aboutStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Html(
                        data: snapshot.data.data
                            .body(AppLocalizations.of(context).locale),
                      ),
                    ),
                  ),
                );
              }
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }
}
