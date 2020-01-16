import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_dark_arch/utils/storage.dart';
import 'package:rxdart/rxdart.dart';

class AuthService extends Disposable {
  BehaviorSubject<bool> _authController = BehaviorSubject<bool>.seeded(false);

  Future<bool> get isAuthorized => _authController.last;

  Stream<bool> get authStream => _authController.stream;

  Future<void> loginSuccessful() async {
    _authController.add(true);
    print('Authorized');
  }

  Future<void> logout() async {
    await Storage().clearStorage();
    _authController.add(false);
    print('Not Authorized');
  }

  @override
  void dispose() {
    _authController.close();
  }
}
