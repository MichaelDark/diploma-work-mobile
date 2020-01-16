import 'package:flutter/material.dart';
import 'package:flutter_dark_arch/res/app_colors.dart';

import 'standard_field.dart';

class DefaultField extends StatelessWidget {
  final FieldData fieldData;
  final String labelText;
  final bool obscuredText;
  final FocusNode nextFocus;
  final VoidCallback onDone;

  DefaultField(
    this.fieldData, {
    @required this.labelText,
    this.obscuredText,
    this.nextFocus,
    this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: StandardField(
        labelText: labelText,
        fieldData: fieldData,
        fontSize: 20,
        fontFamily: 'Montserrat',
        hintFontSize: 18,
        hintFontFamily: 'Montserrat',
        obscuredText: obscuredText ?? false,
        nextFocus: nextFocus,
        onDone: onDone,
        activeColor: Colors.blue,
        activeErrorColor: Colors.red,
        labelColor: AppColors.of(context).textMainColor,
        inactiveColor: Colors.grey,
        inactiveErrorColor: Colors.amber,
      ),
    );
  }
}
