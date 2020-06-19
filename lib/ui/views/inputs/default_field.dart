import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';

import 'standard_field.dart';

class DefaultField extends StatelessWidget {
  final FieldData fieldData;
  final String labelText;
  final int maxLines;
  final bool obscuredText;
  final TextInputType keyboardType;
  final FocusNode nextFocus;
  final VoidCallback onDone;

  DefaultField(
    this.fieldData, {
    @required this.labelText,
    this.obscuredText,
    this.keyboardType,
    this.nextFocus,
    this.onDone,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: StandardField(
        labelText: labelText,
        keyboardType: keyboardType,
        maxLines: maxLines,
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
