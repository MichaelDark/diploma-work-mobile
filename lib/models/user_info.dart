import 'package:flutter/foundation.dart';

class UserInfo {
  final int id;
  final bool isModerator;
  final String maskedEmail;

  UserInfo({
    @required this.id,
    this.isModerator,
    @required this.maskedEmail,
  });
}
