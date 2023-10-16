import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'country.dart';
import 'country_picker_theme_data.dart';
import 'country_list_view.dart';

void showCountryListBottomSheet({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
  VoidCallback? onClosed,
  List<String>? favorite,
  List<String>? exclude,
  List<String>? countryFilter,
  bool showPhoneCode = false,
  CountryPickerThemeData? countryPickerThemeData,
  bool searchAutofocus = false,
  bool showWorldWide = false,
  bool showSearch = true,
  bool useSafeArea = false,
  bool isCupertinoBottomSheet = false,
}) {
  if (isCupertinoBottomSheet) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: kCupertinoModalBarrierColor,
      builder: (context) => _builder(
        context,
        onSelect,
        favorite,
        exclude,
        countryFilter,
        showPhoneCode,
        countryPickerThemeData,
        searchAutofocus,
        showWorldWide,
        showSearch,
      ),
    ).whenComplete(() {
      if (onClosed != null) onClosed();
    });
  } else {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: useSafeArea,
      backgroundColor: Colors.transparent,
      barrierColor: kCupertinoModalBarrierColor,
      builder: (context) => _builder(
        context,
        onSelect,
        favorite,
        exclude,
        countryFilter,
        showPhoneCode,
        countryPickerThemeData,
        searchAutofocus,
        showWorldWide,
        showSearch,
      ),
    ).whenComplete(() {
      if (onClosed != null) onClosed();
    });
  }
}

// ignore: avoid-returning-widgets
Widget _builder(
  BuildContext context,
  ValueChanged<Country> onSelect,
  List<String>? favorite,
  List<String>? exclude,
  List<String>? countryFilter,
  bool showPhoneCode,
  CountryPickerThemeData? countryPickerThemeData,
  bool searchAutofocus,
  bool showWorldWide,
  bool showSearch,
) {
  final MediaQueryData mediaQuery = MediaQuery.of(context);

  final deviceHeight = mediaQuery.size.height;
  final statusBarHeight = mediaQuery.padding.top;
  final effectiveHeight = countryPickerThemeData?.bottomSheetHeight ??
      deviceHeight - (statusBarHeight + (kToolbarHeight / 1.5));

  final Color effectiveBackgroundColor = countryPickerThemeData
          ?.backgroundColor ??
      Theme.of(context).bottomSheetTheme.backgroundColor ??
      CupertinoDynamicColor.resolve(CupertinoColors.systemBackground, context);

  final BorderRadius effectiveBorderRadius =
      countryPickerThemeData?.borderRadius ??
          const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          );

  return Container(
    height: effectiveHeight,
    margin: countryPickerThemeData?.margin,
    padding: countryPickerThemeData?.padding,
    decoration: BoxDecoration(
      color: effectiveBackgroundColor,
      borderRadius: effectiveBorderRadius,
    ),
    child: CountryListView(
      exclude: exclude,
      favorite: favorite,
      countryFilter: countryFilter,
      onSelect: onSelect,
      showSearch: showSearch,
      showPhoneCode: showPhoneCode,
      showWorldWide: showWorldWide,
      searchAutofocus: searchAutofocus,
      countryPickerThemeData: countryPickerThemeData,
    ),
  );
}
