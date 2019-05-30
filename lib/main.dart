import 'package:flutter/material.dart';
import 'package:kib/localization.dart';

import 'common_widgets/onboard_screan.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
