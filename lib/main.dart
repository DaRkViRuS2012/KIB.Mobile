import 'package:flutter/material.dart';
import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/appBloc.dart';
import 'common_widgets/onboard_screan.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';

import 'dataStore/dataStore.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DataStore.initPrefs();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp({Key key, this.prefs})
      : assert(prefs != null),
        super(key: key);
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppBloc bloc;
  Key key;

  @override
  Widget build(BuildContext context) {
    bloc = AppBloc(widget.prefs);
    return BlocProvider(
      bloc: bloc,
      child: MaterialApp(
        key: key,
        debugShowCheckedModeBanner: false,
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ar', ''),
        ],
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {
          for (Locale supportedLocale in supportedLocales) {
            print('Language ' + supportedLocale.languageCode);
            if (locale != null) if (supportedLocale.languageCode ==
                    locale.languageCode ||
                supportedLocale.countryCode == locale.countryCode) {
              print(supportedLocale);
              return supportedLocale;
            }
          }

          return supportedLocales.first;
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
