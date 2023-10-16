# flutter_country_picker

<!-- [![pub package](https://img.shields.io/pub/v/flutter_country_picker.svg)](https://pub.dev/packages/flutter_country_picker) -->

A flutter package to select a country from a list of countries.

<!-- <img height="600" alt="n1" src="https://raw.githubusercontent.com/Daniel-Ioannou/flutter_country_picker/master/assets/ReadMe%20Screenshot.png"> -->

## Screenshots

<a href="https://github.com/ziqq/flutter_country_picker/#/"><img width="410" alt="light theme screenshot" src="https://raw.githubusercontent.com/ziqq/flutter_country_picker/master/.docs/screenshots/1.png"></a>&nbsp;<a href="https://github.com/ziqq/flutter_country_picker/#/"><img width="410" alt="dark theme screenshot" src="https://raw.githubusercontent.com/ziqq/flutter_country_picker/master/.docs/screenshots/2.png"></a>

```sh
  Screenshots must be here
```

## Getting Started

 Add the package to your pubspec.yaml:

 ```yaml
  flutter_country_picker: last version
 ```

 In your dart file, import the library:

 ```dart
  import 'package:flutter_country_picker/flutter_country_picker.dart';
 ```

Show country picker using `showCountryPicker`:
```dart
showCountryPicker(
  context: context,
  showPhoneCode: true, // optional. Shows phone code before the country name.
  onSelect: (Country country) {
    print('Select country: ${country.displayName}');
  },
);
```

### For localization:
Add the `CountryLocalizations.delegate` in the list of your app delegates.
```dart
MaterialApp(
  supportedLocales: [
    const Locale('en'),
    const Locale('el'),
    // Generic Simplified Chinese 'zh_Hans'
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    // Generic traditional Chinese 'zh_Hant'
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ],
  localizationsDelegates: [
    CountryLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  home: HomePage(),
 );
```

### Parameters:
* `sheetType`: Can be used to defines the type of [ModalBottomSheet] can be `material` or `cupertino`, which in turn determines the type of method used for [showModalBottomSheet]. Used packge [modal_bottom_sheet](https://pub.dev/packages/modal_bottom_sheet)
  ```dart
  showCountryPicker(
    context: context,
    sheetType: SheetType.cupertino,
  );
  ```

* `onSelect`: Called when a country is selected. The country picker passes the new value to the callback (required)

* `onClosed`: Called when CountryPicker is dismissed, whether a country is selected or not (optional).

* `showPhoneCode`: Can be used to show phone code before the country name.

* `searchAutofocus` Can be used to initially expand virtual keyboard

* `showSearch` Can be used to show/hide the search bar.

* `showWorldWide` An optional argument for showing "World Wide" option at the beginning of the list

* `favorite` Can be used to show the favorite countries at the top of the list (optional).

* `countryListTheme`: Can be used to customize the country list's bottom sheet and widgets that lie within it. (optional).

  ```dart
  showCountryPicker(
    context: context,
    countryListTheme: CountryPickerThemeData(
      flagSize: 25,
      backgroundColor: Colors.white,
      textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
      // Optional. Country list modal height
      bottomSheetHeight: 500,
      // Optional. Sets the border radius for the bottomsheet.
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      // Optional. Styles the search field.
      inputDecoration: InputDecoration(
        labelText: 'Search',
        hintText: 'Start typing to search',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFF8C98A8).withOpacity(0.2),
          ),
        ),
      ),
    ),
    onSelect: (Country country) => print('Select country: ${country.displayName}'),
  );
  ```

* `exclude`: Can be used to exclude(remove) one or more country from the countries list (optional).
  ```dart
  showCountryPicker(
    context: context,
    // It takes a list of country code(iso2)
    exclude: <String>['KN', 'MF'], .
    onSelect: (Country country) => print('Select country: ${country.displayName}'),
  );
  ```

* `countryFilter`: Can be used to filter the countries list (optional).
  - It takes a list of country code(iso2).
  - Can't provide both exclude and countryFilter


## Contributions
Contributions of any kind are more than welcome! Feel free to fork and improve flutter_country_picker in any way you want, make a pull request, or open an issue.
