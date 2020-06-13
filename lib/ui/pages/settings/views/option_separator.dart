import 'package:flutter/material.dart';

class OptionSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: 8),
      color: Colors.grey.withOpacity(0.6),
    );
  }
}
