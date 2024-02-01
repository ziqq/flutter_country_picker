import 'package:flutter/material.dart';

class CountryPickerThemeData {
  const CountryPickerThemeData({
    this.backgroundColor,
    this.dividerColor,
    this.stickyHeaderBackgroundColor,
    this.textStyle,
    this.searchTextStyle,
    this.flagSize,
    this.inputDecoration,
    this.borderRadius,
    this.bottomSheetHeight,
    this.basePadding,
    this.baseIndent,
    this.padding,
    this.margin,
  });

  /// The country bottom sheet's background color.
  ///
  /// If null, [backgroundColor] defaults to [BottomSheetThemeData.backgroundColor].
  final Color? backgroundColor;

  /// The divider color.
  ///
  /// If null, [dividerColor] defaults to [CupertinoColors.opaqueSeparator].
  final Color? dividerColor;

  /// The country bottom sheet's sticky header background color.
  ///
  /// If null, [stickyHeaderBackgroundColor] defaults to [CupertinoColors.secondarySystemBackground].
  final Color? stickyHeaderBackgroundColor;

  /// The style to use for country name text.
  ///
  /// If null, the style will be set to [TextStyle(fontSize: 16)]
  final TextStyle? textStyle;

  /// The style to use for search box text.
  ///
  /// If null, the style will be set to [TextStyle(fontSize: 16)]
  final TextStyle? searchTextStyle;

  /// The flag size.
  ///
  /// If null, set to 25
  final double? flagSize;

  /// The base indent.
  ///
  /// If null, set to 10
  final double? baseIndent;

  /// The base padding.
  ///
  /// If null, set to 16
  final double? basePadding;

  /// The decoration used for the inputs
  final InputDecoration? inputDecoration;

  /// The border radius of the bottom sheet
  ///
  /// It defaults to 40 for the top-left and top-right values.
  final BorderRadius? borderRadius;

  /// Country list modal height
  ///
  /// By default it's fullscreen
  final double? bottomSheetHeight;

  /// the padding of the bottom sheet
  final EdgeInsets? padding;

  /// the margin of the bottom sheet
  final EdgeInsets? margin;
}
