import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';

class TextOption extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TextOption({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.of(context).black,
                  fontSize: 18,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
