import 'package:dycky_most/Constants/Colors.dart';
import 'package:dycky_most/Misc/DynamicTheme.dart';
import 'package:dycky_most/Misc/PrefService.dart';
import 'package:dycky_most/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() async {
  await PrefService.init(prefix: 'pref_');
  runApp(DyckyMost());
}

class DyckyMost extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) =>
            ThemeData(
              brightness: brightness,
              primaryColor: mainColor,
              accentColor: mainColor,
              textTheme: TextTheme(
                title: TextStyle(fontSize: 18.0),
              ),
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: App.title,
            theme: theme,
            home: App(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('cs', 'CZ'),
            ],
          );
        });
  }
}