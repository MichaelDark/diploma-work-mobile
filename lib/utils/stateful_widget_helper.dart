import 'package:flutter/material.dart';

class StatefulWidgetHelper {
  static void executeAfterBuild(VoidCallback action) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => action(),
    );
  }
}
