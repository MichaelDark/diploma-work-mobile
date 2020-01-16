import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:graduation_work_mobile/utils/functional_interfaces.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc extends BlocBase {
//  void callAuthorized<T>(Subject subject, SingleValueCallback<String, Future<T>> authCallSupplier) {
//      call(subject, () => authCallSupplier(token));
//  }

  Subject<AsyncState<T>> makeCallForSubject<T>(Subject<AsyncState<T>> subject, Supplier<Future<T>> callSupplier) {
    subject.addStream(_wrapFutureWithAsyncState(callSupplier));
    return subject;
  }

  Subject<AsyncState<T>> makeCall<T>(Supplier<Future<T>> callSupplier) {
    return makeCallForSubject(PublishSubject(), callSupplier);
  }

  Stream<AsyncState<T>> _wrapFutureWithAsyncState<T>(Supplier<Future<T>> callSupplier) async* {
    yield LoadingState(true);
    try {
      final call = callSupplier();
      final value = await call;
      yield SuccessState(value);
    } catch (e) {
      yield FailureState(e);
    }
  }
}
