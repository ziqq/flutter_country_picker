library flutter_country_picker;

import 'package:flutter/material.dart';

import 'src/country.dart';
import 'src/country_list_bottom_sheet.dart';
import 'src/country_picker_theme_data.dart';

export 'src/country.dart';
export 'src/country_picker_theme_data.dart';
export 'src/country_localizations.dart';
export 'src/country_parser.dart';
export 'src/country_service.dart';
export 'src/country_phone_input.dart';

/// Shows a bottom sheet containing a list of countries to select one.
///
/// The callback function [onSelect] call when the user select a country.
/// The function called with parameter the country that the user has selected.
/// If the user cancels the bottom sheet, the function is not call.
///
///  An optional [exclude] argument can be used to exclude(remove) one ore more
///  country from the countries list. It takes a list of country code(iso2).
///
/// An optional [countryFilter] argument can be used to filter the
/// list of countries. It takes a list of country code(iso2).
/// Note: Can't provide both [countryFilter] and [exclude]
///
/// An optional [favorite] argument can be used to show countries
/// at the top of the list. It takes a list of country code(iso2).
///
/// An optional [showPhoneCode] argument can be used to show phone code.
///
/// [countryPickerThemeData] can be used to customizing the country list bottom sheet.
///
/// [onClosed] callback which is called when CountryPicker is dismiss,
/// whether a country is selected or not.
///
/// [searchAutofocus] can be used to initially expand virtual keyboard
///
/// An optional [showSearch] argument can be used to show/hide the search bar.
///
/// The `context` argument is used to look up the [Scaffold] for the bottom
/// sheet. It is only used when the method is called. Its corresponding widget
/// can be safely removed from the tree before the bottom sheet is closed.
void showCountryPicker({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
  VoidCallback? onClosed,
  List<String>? favorite,
  List<String>? exclude,
  List<String>? countryFilter,
  CountryPickerThemeData? countryPickerThemeData,
  bool searchAutofocus = false,
  bool showPhoneCode = false,
  bool showWorldWide = false,
  bool showSearch = true,
  bool useSafeArea = false,
  bool isCupertinoBottomSheet = false,
}) {
  assert(
    exclude == null || countryFilter == null,
    'Cannot provide both exclude and countryFilter',
  );
  showCountryListBottomSheet(
    context: context,
    exclude: exclude,
    favorite: favorite,
    countryFilter: countryFilter,
    showSearch: showSearch,
    showPhoneCode: showPhoneCode,
    showWorldWide: showWorldWide,
    searchAutofocus: searchAutofocus,
    onClosed: onClosed,
    onSelect: onSelect,
    useSafeArea: useSafeArea,
    isCupertinoBottomSheet: isCupertinoBottomSheet,
    countryPickerThemeData: countryPickerThemeData,
  );
}
