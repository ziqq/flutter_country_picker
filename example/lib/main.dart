import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

const double kDefaultPadding = 16.0;
const String kDefaultCountry = '🇷🇺 Россия';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'COUNTRY PICKER EXAMPLE',
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

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _country = '🇷🇺 Россия';
  String _countryCode = '7';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('COUNTRY PICKER EXAMPLE'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: kDefaultPadding * 2),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: CupertinoButton.filled(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
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
                      log('[DEBUG]: Selected country $country');
                    },
                    // Optional.
                    // Sets the theme for the country list picker.
                    countryPickerThemeData: CountryPickerThemeData(),
                  ),
                  child: Text(
                    'Show cupertino country picker',
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: CupertinoButton.filled(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  onPressed: () => showCountryPicker(
                    context: context,
                    // Optional.
                    // Can be used to exclude(remove) one ore more country from the countries list (optional).
                    exclude: ['KN', 'MF'],
                    favorite: ['RU'],
                    //Optional. Shows phone code before the country name.
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      log('[DEBUG]: Selected country $country');
                    },
                    // Optional.
                    // Sets the theme for the country list picker.
                    countryPickerThemeData: CountryPickerThemeData(),
                  ),
                  child: Text(
                    'Show default country picker',
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 2),
              CountryPhoneInput(
                country: _country,
                countryCode: _countryCode,
                onTap: () {
                  showCountryPicker(
                    context: context,
                    favorite: ['RU'],
                    exclude: ['KN', 'MF'],
                    showPhoneCode: true,
                    isCupertinoBottomSheet: true,
                    onSelect: (Country country) {
                      log('[DEBUG]: Selected country $country');
                      setState(() {
                        _country =
                            '${country.flagEmoji} ${country.nameLocalized}';
                        _countryCode = country.phoneCode;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
