## 3.1.0
  ### Feat
  - Add `CountryPhoneInput`

## 3.0.0
  ### Feat
  - Add dark mode.

## 2.20.0
  ### Feat
  - Add support for Italian localization.
  ### Fix
  - Fix French Translations.
  - UI filling fix.

## 2.19.0
  ### Feat
  - Add support for Dutch localization.
  - Add `parsePhoneCode` and `tryParsePhoneCode`.

## 2.18.0
  ### Fix
  - Fix Hindi Translations.
  - Removed old country codes for Kosovo (+381 & +386).

## 2.17.0
  ### Feat
  - Add option to hide search bar.
    ```Dart
      showCountryPicker(
        context: context,
        showSearch: false,
        onSelect: (Country country) => print('Select country: ${country.displayName}'),
      );
    ```
  - Add `searchTextStyle`
    ```Dart
      showCountryPicker(
        context: context,
        countryListTheme: CountryPickerThemeData(
          // Optional. Styles the text in the search field
          searchTextStyle: TextStyle(
            color: Colors.blue,
            fontSize: 18,
          ),
        ),
        onSelect: (Country country) => print('Select country: ${country.displayName}'),
      );
    ```
  ### Fix
  - Removed the need of `worldwide.png` and changed to '🌍' emoji.

## 2.16.0
  ### Feat
  - Add support for Latvian localization.
  - Add support for Lithuanian localization.

## 2.15.0
  ### Feat
  - Add support for German localization.
  - Add `favorite` option.
    - Can be used to to show the favorite countries at the top of the list.
    - It takes a list of country code(iso2).
      ```Dart
      showCountryPicker(
        context: context,
        favorite: <String>['SE', 'MC'],
        onSelect: (Country country) {
          print('Select country: ${country.displayName}');
        },
      );
      ```
  - Implemented Country Service.
  ### Fixed
  - Fix package assets.

## 2.14.0
  ### Feat
  - Add support for country search by phone code.

## 2.13.0
  ### Feat
  - Add getter for flag emoji in `Country` model.
  - Add option for bottom sheet height.
    ```Dart
    showCountryPicker(
      context: context,
      countryListTheme: CountryPickerThemeData(
       bottomSheetHeight: 500, // Optional. Country list modal height
      ),
      onSelect: (Country country) => print('Select country: ${country.displayName}'),
    );
    ```
## 2.12.0
  ### Fix
  - Fix Kurdish translation for Curaçao name.
  ### Update
  - Example android gradle.
## 2.11.0
  ### Feat
  - Add optional argument for showing "World Wide" option at the beginning of the list
    ```Dart
    showCountryPicker(
      context: context,
      showWorldWide: true,
      onSelect: (Country country) => print('Select country: ${country.displayName}'),
    );
    ```
  ### Fix
  - Fix Eswatini name.
  - Fix Italy code at Turkish localization.

## 2.10.0
  ### Feat
  - Add support for French localization.
  - Add support for Kurdish localization.

## 2.9.0
  ### Feat
  - Add support for Estonian localization.

## 2.8.0
  ### Feat
  - Add support for Arabic localization.
  - Add support for Croatian localization.
  - Add options to autofocus at search TextField.
    ```Dart
    showCountryPicker(
      context: context,
      searchAutofocus: true,
      onSelect: (Country country) => print('Select country: ${country.displayName}'),
    );
    ```

## 2.7.0
  ### Feat
  - Add support for Turkish localization.

## 2.6.0
  ### Feat
  - Add support for Nepali and Hindi localization.

## 2.5.0
  ### Feat
  - Add styling options for the border-radius and the search field.
    ```Dart
    showCountryPicker(
      context: context,
      countryListTheme: CountryPickerThemeData(
        // Optional. Sets the border radius for the bottomsheet.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
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

## 2.4.0
  ### Feat
  - Add `CountryParser`.

## 2.3.0
  ### Feat
  - Add Ukrainian, Russian, and Polish translations.
  - Add `onClosed` callback.

## 2.2.0
  ### Feat
  - Add support for Norwegian localization.

## 2.1.0
  ### Feat
  - Implemented country list theme
    ```Dart
    showCountryPicker(
      context: context,
      countryListTheme: CountryPickerThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
      ),
      onSelect: (Country country) => print('Select country: ${country.displayName}'),
    );
    ```
## 2.0.0
  ### Update
  - Migrated to null safety.

## 1.10.0
  ### Feat
  - Add support for Spanish and Portuguese localization.
  ### Fix
  - If `showPhoneCode` is false remove duplicates country.

## 1.9.0
  ### Feat
  - Localize label and hint of search text field.

## 1.8.0
  ### Feat
  - Add support for Greek localization.
  - At search change contains to startsWith.
  - Add country filter option.
    - Can be used to uses filter the countries list (optional).
    - It takes a list of country code(iso2).
    - Can't provide both exclude and countryFilter
    ```Dart
     showCountryPicker(
       context: context,
       countryFilter: <String>['AT', 'GB', 'DK', 'DE', 'FR', 'GR'], //It takes a list of country code(iso2).
       onSelect: (Country country) => print('Select country: ${country.displayName}'),
     );
    ```

## 1.7.0
  ### Feat
  - Search on localizations.

## 1.6.0
  ### Feat
  - Implement localization. Add the `CountryLocalizations.delegate` in the list of your app delegates.
  ```Dart
  MaterialApp(
        supportedLocales: [
          const Locale('en'),
          const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
          const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
        ],
        localizationsDelegates: [
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: HomePage(),
  );
  ```
  - Add supported languages:
    * English
    * Simplified Chinese
    * Traditional Chinese

## 1.5.0
  ### Update
  - Documentation.

## 1.4.0
  ### Feat
  - Implement search.

## 1.3.0
  ### Feat
  - Add show phone code option.

## 1.2.0
  ### Feat
  - Add exclude countries option.
    Can be used to exclude(remove) one ore more country from the countries list
    ```Dart
    showCountryPicker(
       context: context,
       exclude: <String>['KN', 'MF'], //It takes a list of country code(iso2).
       onSelect: (Country country) => print('Select country: ${country.displayName}'),
    );
    ```

## 1.1.0
  ### Feat
  - Add documentation.

## 1.0.0
  ### Feat
  - Initial preview release.
