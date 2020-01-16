import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/utils/functional_interfaces.dart';
import 'package:rxdart/rxdart.dart';

import 'async_stream_builder.dart';
import 'states.dart';

class AsyncSubjectBuilder<T> extends StatefulWidget {
  final Subject<AsyncState<T>> subject;
  final VoidCallback onReload;
  final SingleValueCallback<BuildContext, Widget> initialBuilder;
  final SingleValueCallback<BuildContext, Widget> loadingBuilder;
  final DoubleValueCallback<BuildContext, T, Widget> successBuilder;
  final DoubleValueCallback<BuildContext, dynamic, Widget> failureBuilder;

  const AsyncSubjectBuilder(
    this.subject, {
    this.onReload,
    this.initialBuilder,
    this.loadingBuilder,
    this.successBuilder,
    this.failureBuilder,
  }) : assert(subject != null);

  @override
  _AsyncSubjectBuilderState<T> createState() => _AsyncSubjectBuilderState<T>();
}

class _AsyncSubjectBuilderState<T> extends State<AsyncSubjectBuilder<T>> {
  @override
  void dispose() {
    super.dispose();
    widget.subject.drain().then((c) {
      widget.subject.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AsyncStreamBuilder<T>(
      widget.subject,
      onReload: widget.onReload,
      initialBuilder: widget.initialBuilder,
      loadingBuilder: widget.loadingBuilder,
      successBuilder: widget.successBuilder,
      failureBuilder: widget.failureBuilder,
    );
  }
}
