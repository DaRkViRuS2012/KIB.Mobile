import 'package:flutter/material.dart';
import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/appBloc.dart';
import 'common_widgets/onboard_screan.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';

import 'dataStore/dataStore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await DataStore.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // final DataStore data;

  const MyApp({
    Key key,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());

    state.setState(() {
      state.selectedLocale = newLocale;
    });
  }
}

class _MyAppState extends State<MyApp> {
  static AppBloc bloc;
  Key key;
  Locale selectedLocale;
  @override
  void initState() {
    super.initState();
    bloc = AppBloc();
    bloc.fetchLocale();
    var locale = DataStore().getLocale();
    if (locale != null) {
      selectedLocale = locale;
    }
  }

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());
    DataStore().setLocale(newLocale);
    bloc.changeLocale(newLocale);
    state.setState(() {
      state.selectedLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Locale>(
        stream: bloc.selectedLocaleStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return mainWidget();
          } else if (snapshot.hasData) {
            // selectedLocale = snapshot.data;
            return mainWidget();
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  mainWidget() {
    return BlocProvider(
      bloc: bloc,
      child: MaterialApp(
        key: key,
        locale: selectedLocale,
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
        title: 'KIB',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
