import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(4),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 28,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.of(context).black,
                fontSize: 36,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
