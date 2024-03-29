# CountryPicker: A flutter package to select a country from a list of countries

[![Pub](https://img.shields.io/pub/v/flutter_country_picker.svg)](https://pub.dev/packages/flutter_country_picker)
[![Actions Status](https://github.com/ziqq/flutter_country_picker/actions/workflows/checkout.yml/badge.svg)](https://github.com/ziqq/flutter_country_picker/actions)
[![Coverage](https://codecov.io/gh/ziqq/flutter_country_picker/branch/master/graph/badge.svg)](https://codecov.io/gh/ziqq/flutter_country_picker)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![Linter](https://img.shields.io/badge/style-linter-40c4ff.svg)](https://pub.dev/packages/linter)
[![GitHub stars](https://img.shields.io/github/stars/ziqq/flutter_country_picker?style=social)](https://github.com/ziqq/flutter_country_picker/)

## Screenshots

<a href="https://github.com/ziqq/flutter_country_picker/#/"><img width="412.5" alt="light theme screenshot" src="https://raw.githubusercontent.com/ziqq/flutter_country_picker/master/.docs/screenshots/1.png"></a>&nbsp;<a href="https://github.com/ziqq/flutter_country_picker/#/"><img width="412.5" alt="dark theme screenshot" src="https://raw.githubusercontent.com/ziqq/flutter_country_picker/master/.docs/screenshots/2.png"></a>

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
  showPhoneCode: true, // Optional. Shows phone code before the country name.
  onSelect: (Country country) {
    debugPrint('Select country: ${country.displayName}');
  },
);
```

Use country phone input without country picker using `CountryPhoneInput`:
```dart
CountryPhoneInput();
```

Use country phone input with country picker using `CountryPhoneInput`:

```dart
CountryPhoneInput(
  controller: _controller,
  mask: _mask,
  country: _country,
  countryCode: _countryCode,
  onTap: () {
    showCountryPicker(
      context: context,
      exclude: ['KN'],
      favorite: ['RU'],
      showPhoneCode: true,
      sheetType: SheetType.cupertino,
      onSelect: (Country country) {
        setState(() {
          _country = '${country.flagEmoji} ${country.nameLocalized}';
          _countryCode = country.phoneCode;
          _mask = country.mask;
        });
      },
    );
  },
);
```

Use `TextEditingController` to get current phone value on any event:
```dart
CupertinoButton.filled(
  onPressed: () => setState(() => _phone = "+$_countryCode${_controller.text.replaceAll(" ", "")}"),
  child: Text('Submit', style: TextStyle(color: CupertinoColors.white)),
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
* `onSelect`: Called when a country is selected. The country picker passes the new value to the callback (required)

* `onClosed`: Called when CountryPicker is dismissed, whether a country is selected or not (optional).

* `showPhoneCode`: Can be used to show phone code before the country name.

* `searchAutofocus` Can be used to initially expand virtual keyboard

* `showSearch` Can be used to show/hide the search bar.

* `showWorldWide` An optional argument for showing "World Wide" option at the beginning of the list

* `sheetType`: Can be used to defines the type of [ModalBottomSheet] can be `material` or `cupertino`, which in turn determines the type of method used for [showModalBottomSheet]. Used packge [modal_bottom_sheet](https://pub.dev/packages/modal_bottom_sheet)
  ```dart
  showCountryPicker(
    context: context,
    sheetType: SheetType.cupertino,
  );
  ```

* `countryListTheme`: Can be used to customize the country list's bottom sheet and widgets that lie within it. (optional).

  ```dart
  showCountryPicker(
    context: context,
    countryListTheme: CountryPickerThemeData(
      flagSize: 25,
      backgroundColor: Colors.white,
      textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
      bottomSheetHeight: 500, // Optional. Country list modal height
      borderRadius: BorderRadius.only( // Optional. Sets the border radius for the bottomsheet.
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      inputDecoration: InputDecoration( // Optional. Styles the search field.
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
    exclude: <String>['KN', 'MF'], // It takes a list of country code(iso2)
    onSelect: (Country country) => print('Select country: ${country.displayName}'),
  );
  ```

* `countryFilter`: Can be used to filter the countries list (optional).
  - It takes a list of country code(iso2).
  - Can't provide both exclude and countryFilter

* `favorite` Can be used to show the favorite countries at the top of the list (optional).


## Contributions
Contributions of any kind are more than welcome! Feel free to fork and improve flutter_country_picker in any way you want, make a pull request, or open an issue.
