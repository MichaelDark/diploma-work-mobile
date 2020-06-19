import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/architecture/utils/async_stream_builder.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:graduation_work_mobile/ui/views/buttons/colored_button.dart';
import 'package:graduation_work_mobile/ui/views/error_view.dart';
import 'package:graduation_work_mobile/ui/views/inputs/default_field.dart';
import 'package:graduation_work_mobile/ui/views/inputs/standard_field.dart';
import 'package:graduation_work_mobile/ui/views/no_glow_scroll_behavior.dart';
import 'package:graduation_work_mobile/ui/views/title_view.dart';
import 'package:graduation_work_mobile/utils/extensions/context.dart';
import 'package:graduation_work_mobile/utils/validator.dart';
import 'package:graduation_work_mobile/utils/validators.dart';

import 'forgot_password_page_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

enum _ForgotPasswordField { Email }

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  ForgotPasswordPageBloc _bloc = BlocProvider.getBloc<ForgotPasswordPageBloc>();
  Map<_ForgotPasswordField, FieldData> _fields = Map.fromIterable(
    _ForgotPasswordField.values,
    key: (f) => f,
    value: (f) => FieldData(),
  );

  @override
  void initState() {
    super.initState();
    _bloc.forgotPasswordSubject.listen((dynamic state) async {
      if (mounted && state is SuccessState<String>) {
        context.pushFirstPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.forgotPasswordSubject.value = null;
  }

  void _onRestoreTap() async {
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
      final validator = Validator()
        ..add<String, String>(
          data: _fields[_ForgotPasswordField.Email].controller.text,
          onValidate: getEmailValidation(context),
          onValid: (_) => _fields[_ForgotPasswordField.Email].errorText = null,
          onInvalid: (String errorText) => _fields[_ForgotPasswordField.Email].errorText = errorText,
        );
      if (validator.validate()) {
        _bloc.forgotPassword(_fields[_ForgotPasswordField.Email].controller.text);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: ListView(
          children: <Widget>[
            _buildBackButton(),
            _buildBodyColumn(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.all(16),
          icon: Icon(Icons.arrow_back),
        ),
      ],
    );
  }

  Widget _buildBodyColumn() {
    return Column(
      children: <Widget>[
        TitleView(
          text: context.strings.passwordRestore,
          textAlign: TextAlign.center,
          fontSize: 24,
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            context.strings.receiveYourNewPasswordByEmail,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        DefaultField(
          _fields[_ForgotPasswordField.Email],
          labelText: context.strings.email,
          onDone: _onRestoreTap,
        ),
        SizedBox(height: 16),
        _buildButtons(),
      ],
    );
  }

  Widget _buildButtons() {
    return AsyncStreamBuilder<void>(
      _bloc.forgotPasswordSubject.stream,
      onReload: _onRestoreTap,
      initialBuilder: (_) => _buildForgotPasswordButton(),
      failureBuilder: (_, error) => ErrorView(error, onReload: _onRestoreTap, margin: EdgeInsets.all(24)),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: ColoredButton(
        text: context.strings.receiveNewPassword,
        onPressed: (_) => _onRestoreTap(),
      ),
    );
  }
}
