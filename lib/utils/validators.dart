import 'package:flutter/cupertino.dart';
import 'package:graduation_work_mobile/res/strings.dart';

import 'functional_interfaces.dart';

SingleValueCallback<String, String> getEmailValidation(BuildContext context) {
  return (String email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(email)) return Strings.of(context).invalidEmail;
    return null;
  };
}

SingleValueCallback<String, String> getEmptyValidation(BuildContext context) {
  return (String text) {
    if (text == null || text.isEmpty) return Strings.of(context).fieldIsRequired;
    return null;
  };
}

SingleValueCallback<String, String> getPasswordValidation(BuildContext context) {
  return (String text) {
    if (text == null || text.length < 8) return Strings.of(context).passwordShouldContain;
    return null;
  };
}
