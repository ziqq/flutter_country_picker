import 'package:flutter/cupertino.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

const double kDefaultPadding = 16;
const String kDefaultCountry = '🇷🇺 Россия';

const List<Locale> supportedLocales = [
  Locale('en'),
  Locale('ru'),
  // Locale('ar'),
  // Locale('es'),
  // Locale('de'),
  // Locale('fr'),
  // Locale('el'),
  // Locale('et'),
  // Locale('nb'),
  // Locale('nn'),
  // Locale('pl'),
  // Locale('pt'),
  // Locale('ru'),
  // Locale('hi'),
  // Locale('ne'),
  // Locale('uk'),
  // Locale('hr'),
  // Locale('tr'),
  // Locale('lv'),
  // Locale('lt'),
  // Locale('ku'),
  // Locale('nl'),
  // Locale('it'),
  // Generic Simplified Chinese 'zh_Hans'
  // Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
  // Generic traditional Chinese 'zh_Hant'
  // Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => CupertinoApp(
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
        locale: const Locale('ru'),
        supportedLocales: supportedLocales,
        localizationsDelegates: const [
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialWithModalsPageRoute(
                builder: (_) => const HomePage(),
                settings: settings,
              );
          }
          return MaterialWithModalsPageRoute(
            builder: (context) => const HomePage(),
          );
        },
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  String _country = '🇷🇺 Россия';
  String _countryCode = '7';
  String? _mask = '000 000 0000';

  @override
  Widget build(BuildContext context) {
    final Color effectiveButtonColor = CupertinoDynamicColor.resolve(
      CupertinoColors.systemBlue,
      context,
    );

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('COUNTRY PICKER EXAMPLE'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: kDefaultPadding * 2),
            const Spacer(),
            CountryPhoneInput(
              autofocus: false,
              controller: _controller,
              mask: _mask,
              country: _country,
              countryCode: _countryCode,
              onTap: () {
                showCountryPicker(
                  context: context,
                  favorite: ['RU'],
                  exclude: ['KN', 'MF'],
                  showPhoneCode: true,
                  sheetType: SheetType.cupertino,
                  supportedLocales: supportedLocales,
                  onSelect: (country) {
                    debugPrint('[DEBUG]: Selected country $country');
                    setState(() {
                      _country =
                          '${country.flagEmoji} ${country.nameLocalized}';
                      _countryCode = country.phoneCode;
                      _mask = country.mask;
                    });
                  },
                  onClosed: () {
                    debugPrint('[DEBUG]: onClosed called');
                  },
                );
              },
            ),
            const SizedBox(height: kDefaultPadding * 2),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              child: CupertinoButton(
                color: effectiveButtonColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                onPressed: () {
                  debugPrint(
                    "[DEBUG]: PHONE: +$_countryCode${_controller.text.replaceAll(" ", "")}",
                  );
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: CupertinoColors.white),
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              child: CupertinoButton(
                color: effectiveButtonColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                onPressed: () => showCountryPicker(
                  context: context,
                  sheetType: SheetType.cupertino,
                  // Optional.
                  // Can be used to exclude(remove) one ore more country from the countries list (optional).
                  exclude: ['KN', 'MF'],
                  favorite: ['RU'],
                  //Optional. Shows phone code before the country name.
                  showPhoneCode: true,
                  onSelect: (country) {
                    debugPrint('[DEBUG]: Selected country $country');
                  },
                  // Optional.
                  // Sets the theme for the country list picker.
                  countryPickerThemeData: const CountryPickerThemeData(),
                ),
                child: const Text(
                  'Show cupertino picker',
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
              child: CupertinoButton(
                color: effectiveButtonColor,
                padding: const EdgeInsets.symmetric(
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
                  onSelect: (country) {
                    debugPrint('[DEBUG]: Selected country $country');
                  },
                  // Optional.
                  // Sets the theme for the country list picker.
                  countryPickerThemeData: const CountryPickerThemeData(),
                ),
                child: const Text(
                  'Show material picker',
                  style: TextStyle(color: CupertinoColors.white),
                ),
              ),
            ),
            if (MediaQuery.of(context).viewPadding.bottom == 0) ...[
              const SizedBox(height: kDefaultPadding),
            ],
          ],
        ),
      ),
    );
  }
}
