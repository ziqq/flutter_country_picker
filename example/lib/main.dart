import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:country_picker/country_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo for country picker package',
      // themeMode: ThemeMode.dark,
      // darkTheme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      locale: Locale('ru'),
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
        const Locale('es'),
        const Locale('de'),
        const Locale('fr'),
        const Locale('el'),
        const Locale('et'),
        const Locale('nb'),
        const Locale('nn'),
        const Locale('pl'),
        const Locale('pt'),
        const Locale('ru'),
        const Locale('hi'),
        const Locale('ne'),
        const Locale('uk'),
        const Locale('hr'),
        const Locale('tr'),
        const Locale('lv'),
        const Locale('lt'),
        const Locale('ku'),
        const Locale('nl'),
        const Locale('it'),
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialWithModalsPageRoute(
              builder: (_) => HomePage(),
              settings: settings,
            );
        }
        return MaterialWithModalsPageRoute(
          builder: (context) => HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Demo for country picker'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    onPressed: () => showCountryPicker(
                      context: context,
                      isCupertinoBottomSheet: true,
                      // Optional.
                      // Can be used to exclude(remove) one ore more country from the countries list (optional).
                      exclude: ['KN', 'MF'],
                      favorite: ['RU'],
                      //Optional. Shows phone code before the country name.
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        log('--------> Select country: $country');
                      },
                      // Optional.
                      // Sets the theme for the country list picker.
                      countryListTheme: CountryListThemeData(),
                    ),
                    child: Text(
                      'Show cupertino country picker',
                      style: TextStyle(
                        color: CupertinoDynamicColor.resolve(
                          CupertinoColors.label,
                          context,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    onPressed: () => showCountryPicker(
                      context: context,
                      // Optional.
                      // Can be used to exclude(remove) one ore more country from the countries list (optional).
                      exclude: ['KN', 'MF'],
                      favorite: ['RU'],
                      //Optional. Shows phone code before the country name.
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        log('--------> Select country: $country');
                      },
                      // Optional.
                      // Sets the theme for the country list picker.
                      countryListTheme: CountryListThemeData(),
                    ),
                    child: Text(
                      'Show default country picker',
                      style: TextStyle(
                        color: CupertinoDynamicColor.resolve(
                          CupertinoColors.label,
                          context,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
