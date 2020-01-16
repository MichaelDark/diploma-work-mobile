import 'package:flutter/material.dart';
import 'package:flutter_dark_arch/utils/functional_interfaces.dart';

class FieldData {
  final FocusNode node = FocusNode();
  final TextEditingController controller = TextEditingController();

  String errorText;

  FieldData();

  FieldData.withError(this.errorText);
}

class StandardField extends StatelessWidget {
  final FieldData fieldData;
  final String labelText;
  final bool obscuredText;
  final EdgeInsets additionalPadding;

  final FocusNode nextFocus;
  final VoidCallback onDone;
  final SingleCallback<String> onChanged;

  final Color activeColor;
  final Color inactiveColor;

  final Color activeErrorColor;
  final Color inactiveErrorColor;
  final Color labelColor;

  final double fontSize;
  final Color fontColor;
  final String fontFamily;
  final FontWeight fontWeight;

  final double hintFontSize;
  final Color hintFontColor;
  final String hintFontFamily;
  final FontWeight hintFontWeight;

  /// [nextFocus] is valid ONLY if [onDone] is `null`
  const StandardField({
    @required this.fieldData,
    @required this.labelText,
    @required this.activeColor,
    @required this.inactiveColor,
    @required this.activeErrorColor,
    @required this.inactiveErrorColor,
    @required this.labelColor,
    this.fontSize = 14,
    this.fontColor = Colors.black,
    this.fontFamily = 'Montserrat',
    this.fontWeight = FontWeight.w500,
    this.hintFontSize = 14,
    this.hintFontColor = Colors.grey,
    this.hintFontFamily = 'Montserrat',
    this.hintFontWeight = FontWeight.w400,
    this.nextFocus,
    this.onDone,
    this.onChanged,
    bool obscuredText,
    this.additionalPadding,
  }) : obscuredText = obscuredText ?? false;

  TextInputAction getTextInputAction() {
    if (onDone != null) {
      return TextInputAction.done;
    } else if (nextFocus != null) {
      return TextInputAction.next;
    }
    return TextInputAction.done;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldData.controller,
      focusNode: fieldData.node,
      style: createTextFieldStyle(),
      cursorColor: activeColor,
      decoration: createInputDecoration(
        context,
        labelText: labelText,
        errorText: fieldData.errorText,
        contentPadding: EdgeInsets.only(top: 8, bottom: 8).add(additionalPadding ?? EdgeInsets.zero),
      ),
      textInputAction: getTextInputAction(),
      obscureText: obscuredText ?? false,
      onChanged: (value) {
        onChanged(value);
      },
      onEditingComplete: () {
        if (onDone != null) {
          onDone();
        } else if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
    );
  }

  TextStyle createTextFieldStyle() {
    return TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
    );
  }

  InputDecoration createInputDecoration(
    BuildContext context, {
    String labelText,
    String errorText,
    EdgeInsets contentPadding,
  }) {
    return InputDecoration(
      // hasFloatingPlaceholder: true,
      labelText: labelText,
      errorText: errorText,
      alignLabelWithHint: true,
      contentPadding: contentPadding,
      focusedBorder: createInputBorder(activeColor),
      errorBorder: createInputBorder(inactiveErrorColor),
      focusedErrorBorder: createInputBorder(activeErrorColor),
      border: createInputBorder(inactiveColor),
      disabledBorder: createInputBorder(inactiveColor),
      enabledBorder: createInputBorder(inactiveColor),
      labelStyle: createTextFieldLabelStyle(context),
      helperStyle: createTextFieldLabelStyle(context),
      hintStyle: createTextFieldLabelStyle(context),
    );
  }

  InputBorder createInputBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
      ),
    );
  }

  TextStyle createTextFieldLabelStyle(BuildContext context) {
    return TextStyle(
      color: hintFontColor,
      fontSize: hintFontSize,
      fontFamily: hintFontFamily,
      fontWeight: hintFontWeight,
    );
  }
}
