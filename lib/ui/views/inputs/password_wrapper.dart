import 'package:flutter/material.dart';
import 'package:flutter_dark_arch/utils/functional_interfaces.dart';

import 'standard_field.dart';

class PasswordWrapper extends StatefulWidget {
  final DoubleValueCallback<BuildContext, bool, StandardField> obscuredFieldBuilder;
  final Color obscuredColor;
  final Color notObscuredColor;

  const PasswordWrapper({
    @required this.obscuredFieldBuilder,
    @required this.obscuredColor,
    @required this.notObscuredColor,
  });

  @override
  _PasswordWrapperState createState() => _PasswordWrapperState();
}

class _PasswordWrapperState extends State<PasswordWrapper> {
  bool obscuredPassword = true;

  @override
  Widget build(BuildContext context) {
    Color obscureButtonColor;

    if (obscuredPassword) {
      obscureButtonColor = widget.obscuredColor;
    } else {
      obscureButtonColor = widget.notObscuredColor;
    }

    return Stack(
      children: <Widget>[
        widget.obscuredFieldBuilder(context, obscuredPassword),
        Positioned(
          right: 0,
          bottom: 0,
          child: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              size: 20,
              color: obscureButtonColor,
            ),
            onPressed: () {
              setState(() {
                obscuredPassword = !obscuredPassword;
              });
            },
          ),
        )
      ],
    );
  }
}
