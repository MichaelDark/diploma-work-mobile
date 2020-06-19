import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/utils/functional_interfaces.dart';

const _defaultWidthFactor = 0.9;

class ColoredButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final double widthFactor;
  final Color primaryColor;
  final Color secondaryColor;
  final EdgeInsets padding;
  final SingleCallback<BuildContext> onPressed;

  final bool _isOutlined;

  ColoredButton({
    @required this.text,
    @required this.onPressed,
    this.widthFactor = _defaultWidthFactor,
    this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    this.fontSize,
    this.primaryColor,
    this.secondaryColor,
  }) : _isOutlined = false;

  ColoredButton.outlined({
    @required this.text,
    @required this.onPressed,
    this.widthFactor = _defaultWidthFactor,
    this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    this.fontSize,
    this.primaryColor,
    this.secondaryColor,
  }) : _isOutlined = true;

  @override
  Widget build(BuildContext context) {
    Color colorPrimary = primaryColor ?? AppColors.of(context).themeUiColor;
    Color colorSecondary = secondaryColor ?? AppColors.of(context).white;

    return Container(
      width: double.infinity,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: ButtonTheme(
          padding: padding,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: colorPrimary,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(96),
            ),
            color: _isOutlined ? colorSecondary : colorPrimary,
            textColor: Colors.white,
            elevation: 0,
            onPressed: () => onPressed(context),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: _isOutlined ? colorPrimary : colorSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
