// autor - <a.a.ustinoff@gmail.com> Anton Ustinoff

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'country_picker_theme_data.dart';
import 'helpers/constants.dart';

class CountryPhoneInput extends StatefulWidget {
  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  final String country;
  final String countryCode;

  final TextStyle? textStyle;

  /// An optional argument for customizing the [CountryPhoneInput].
  final CountryPickerThemeData? countryPickerThemeData;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final void Function(String)? onChanged;

  const CountryPhoneInput({
    this.autofocus = true,
    this.country = '🇷🇺 Россия',
    this.countryCode = '7',
    this.textStyle,
    this.countryPickerThemeData,
    this.controller,
    this.onTap,
    this.onLongPress,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<CountryPhoneInput> createState() => CountryPhoneInputState();
}

class CountryPhoneInputState extends State<CountryPhoneInput> {
  late String _country;
  late String _countryCode;

  late final TextEditingController _controller;
  late final MaskTextInputFormatter _maskFormatter;

  @override
  void initState() {
    super.initState();

    _country = widget.country;
    _countryCode = widget.countryCode;
    _controller = widget.controller ?? TextEditingController();

    _maskFormatter = MaskTextInputFormatter(
      mask: '### ### ####',
      filter: {'#': RegExp('[0-9]')},
      initialText: _controller.text,
    );
  }

  @override
  void didUpdateWidget(covariant CountryPhoneInput oldWidget) {
    if (widget.countryCode != oldWidget.countryCode) {
      _countryCode = widget.countryCode;
    }
    if (widget.country != oldWidget.country) {
      _country = widget.country;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CountryPickerThemeData? _customThemeData =
        widget.countryPickerThemeData;

    final TextStyle? _defaultTextStyle =
        (widget.textStyle ?? Theme.of(context).textTheme.bodyLarge)?.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            letterSpacing: Platform.isIOS ? -0.3 : 0,
            color: CupertinoDynamicColor.resolve(
              CupertinoColors.label,
              context,
            ),
            fontFamily: Platform.isIOS ? 'SF-Pro-Rounded' : null);

    final Color effectiveBackgroundColor = _customThemeData?.backgroundColor ??
        CupertinoDynamicColor.resolve(
            CupertinoColors.systemBackground, context);

    final Color effectiveDividerColor = _customThemeData?.dividerColor ??
        CupertinoDynamicColor.resolve(CupertinoColors.opaqueSeparator, context);

    final Color effectiveHintColor = _customThemeData
            ?.inputDecoration?.hintStyle?.color ??
        CupertinoDynamicColor.resolve(CupertinoColors.placeholderText, context);

    final effectiveCountryNamePadding = _customThemeData != null &&
            _customThemeData.basePadding != null &&
            _customThemeData.baseIndent != null
        ? EdgeInsets.only(
            top: _customThemeData.baseIndent!,
            bottom: _customThemeData.baseIndent!,
            left: _customThemeData.basePadding!,
            right: _customThemeData.basePadding! / 2,
          )
        : const EdgeInsets.only(
            top: kDefaultIndent,
            bottom: kDefaultIndent,
            left: kDefaultPadding,
            right: kDefaultPadding / 2,
          );

    final effectiveInputPadding = _customThemeData != null &&
            _customThemeData.basePadding != null &&
            _customThemeData.baseIndent != null
        ? EdgeInsets.symmetric(
            horizontal: _customThemeData.basePadding!,
            vertical: _customThemeData.baseIndent!,
          )
        : const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultIndent,
          );

    return Material(
      color: effectiveBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: 1, thickness: 1, color: effectiveDividerColor),

          // Country name with flag
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              widget.onTap?.call();
            },
            onLongPress: widget.onLongPress,
            child: Container(
              width: double.infinity,
              padding: effectiveCountryNamePadding,
              child: Text(
                _country,
                style: _defaultTextStyle?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Divider
          SizedBox(
            height: 1,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 1),
              painter: _CustomDividerPainter(
                color: effectiveDividerColor,
              ),
            ),
          ),

          // Input with mask
          Row(
            children: [
              Padding(
                padding: effectiveInputPadding,
                child: Text(
                  '+ $_countryCode',
                  style: _defaultTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
                child: VerticalDivider(
                  color: effectiveDividerColor,
                  thickness: 1,
                ),
              ),
              Flexible(
                child: TextFormField(
                  style: _defaultTextStyle,
                  controller: _controller,
                  autofocus: widget.autofocus,
                  inputFormatters: [_maskFormatter],
                  keyboardType: TextInputType.number,
                  cursorColor: _defaultTextStyle?.color,
                  cursorHeight: _defaultTextStyle?.fontSize,
                  onChanged: (_) => widget.onChanged?.call(
                    '+ $_countryCode ${_controller.text}',
                  ),
                  decoration: InputDecoration(
                    hintText: kDefaultPhoneMask,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                    hintStyle: _defaultTextStyle?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: effectiveHintColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 1, thickness: 1, color: effectiveDividerColor),
        ],
      ),
    );
  }
}

class _CustomDividerPainter extends CustomPainter {
  final Color? color;

  _CustomDividerPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const pointMode = ui.PointMode.polygon;
    final points = [
      Offset.zero,
      const Offset(33, 0),
      const Offset(38, 6),
      const Offset(44, 0),
      Offset(size.width, 0),
    ];
    final paint = Paint()
      ..color = color ?? Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
