import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/utils/functional_interfaces.dart';

class OutlinedSmallButton extends StatelessWidget {
  final String text;
  final SingleCallback<BuildContext> onPressed;

  OutlinedSmallButton({
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      borderSide: BorderSide(
        color: AppColors.of(context).themeUiColor,
      ),
      textColor: AppColors.of(context).themeUiColor,
      onPressed: () => onPressed?.call(context),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
