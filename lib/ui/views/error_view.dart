import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dark_arch/res/app_colors.dart';
import 'package:flutter_dark_arch/res/strings.dart';

import 'buttons/outlined_small_button.dart';

class ErrorView extends StatelessWidget {
  final error;
  final VoidCallback onReload;
  final EdgeInsets margin;

  const ErrorView(
    this.error, {
    @required this.onReload,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    String message;
    if (error is SocketException) {
      message = Strings.of(context).textNoInternet;
    } else {
      message = Strings.of(context).error;
    }
    return Center(
      child: Container(
        margin: margin,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: AppColors.of(context).errorColor.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                '$message',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                  color: AppColors.of(context).errorColor,
                ),
              ),
            ),
            OutlinedSmallButton(
              text: Strings.of(context).tryAgainWithExclamation,
              onPressed: (BuildContext context) {
                onReload();
              },
            ),
          ],
        ),
      ),
    );
  }
}
