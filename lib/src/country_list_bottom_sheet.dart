import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'country.dart';
import 'country_list_theme_data.dart';
import 'country_list_view.dart';

void showCountryListBottomSheet({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
  VoidCallback? onClosed,
  List<String>? favorite,
  List<String>? exclude,
  List<String>? countryFilter,
  bool showPhoneCode = false,
  CountryListThemeData? countryListTheme,
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
        countryListTheme,
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
        countryListTheme,
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
  CountryListThemeData? countryListTheme,
  bool searchAutofocus,
  bool showWorldWide,
  bool showSearch,
) {
  final device = MediaQuery.of(context).size.height;
  final statusBarHeight = MediaQuery.of(context).padding.top;
  final height = countryListTheme?.bottomSheetHeight ??
      device - (statusBarHeight + (kToolbarHeight / 1.5));

  Color? backgroundColor = countryListTheme?.backgroundColor ??
      Theme.of(context).bottomSheetTheme.backgroundColor;

  backgroundColor ??= CupertinoDynamicColor.resolve(
    CupertinoColors.systemBackground,
    context,
  );

  final BorderRadius borderRadius = countryListTheme?.borderRadius ??
      const BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      );

  return Container(
    height: height,
    padding: countryListTheme?.padding,
    margin: countryListTheme?.margin,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius,
    ),
    child: CountryListView(
      onSelect: onSelect,
      exclude: exclude,
      favorite: favorite,
      countryFilter: countryFilter,
      showPhoneCode: showPhoneCode,
      countryListTheme: countryListTheme,
      searchAutofocus: searchAutofocus,
      showWorldWide: showWorldWide,
      showSearch: showSearch,
    ),
  );
}
