import 'package:flutter/cupertino.dart';
import 'package:flutter_dark_arch/res/app_colors.dart';

class TitleView extends StatelessWidget {
  final String text;
  final double titleWidth;
  final TextAlign textAlign;
  final double fontSize;
  final EdgeInsets margin;

  const TitleView({
    Key key,
    @required this.text,
    this.fontSize,
    this.titleWidth,
    this.margin,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: titleWidth,
      margin: margin,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize ?? 28,
          height: 1.2,
          color: AppColors.of(context).textMainColor,
        ),
      ),
    );
  }
}
