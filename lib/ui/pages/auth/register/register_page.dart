import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/architecture/utils/async_stream_builder.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/ui/views/buttons/colored_button.dart';
import 'package:graduation_work_mobile/ui/views/error_view.dart';
import 'package:graduation_work_mobile/ui/views/inputs/default_field.dart';
import 'package:graduation_work_mobile/ui/views/inputs/standard_field.dart';
import 'package:graduation_work_mobile/ui/views/scrollable_viewport.dart';
import 'package:graduation_work_mobile/ui/views/title_view.dart';
import 'package:graduation_work_mobile/utils/extensions/context.dart';
import 'package:graduation_work_mobile/utils/storage.dart';
import 'package:graduation_work_mobile/utils/validator.dart';
import 'package:graduation_work_mobile/utils/validators.dart';

import 'register_page_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

enum _RegisterField { Email, Name, Password }

class _RegisterPageState extends State<RegisterPage> {
  RegisterPageBloc _bloc = BlocProvider.getBloc<RegisterPageBloc>();
  Map<_RegisterField, FieldData> _fields = Map.fromIterable(
    _RegisterField.values,
    key: (f) => f,
    value: (f) => FieldData(),
  );

  @override
  void initState() {
    super.initState();
    _bloc.registerSubject.listen((dynamic state) async {
      if (mounted && state is SuccessState<String>) {
        await Storage().setUserEmail(state.data);
        context.pushFirstPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.registerSubject.value = null;
  }

  void _onRegisterTap() async {
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
      final validator = Validator()
        ..add<String, String>(
          data: _fields[_RegisterField.Email].controller.text,
          onValidate: getEmailValidation(context),
          onValid: (_) => _fields[_RegisterField.Email].errorText = null,
          onInvalid: (String errorText) => _fields[_RegisterField.Email].errorText = errorText,
        )
        ..add<String, String>(
          data: _fields[_RegisterField.Name].controller.text,
          onValidate: getEmptyValidation(context),
          onValid: (_) => _fields[_RegisterField.Name].errorText = null,
          onInvalid: (String errorText) => _fields[_RegisterField.Name].errorText = errorText,
        )
        ..add<String, String>(
          data: _fields[_RegisterField.Password].controller.text,
          onValidate: getPasswordValidation(context),
          onValid: (_) => _fields[_RegisterField.Password].errorText = null,
          onInvalid: (String errorText) => _fields[_RegisterField.Password].errorText = errorText,
        );
      if (validator.validate()) {
        _bloc.register(
          email: _fields[_RegisterField.Email].controller.text,
          name: _fields[_RegisterField.Name].controller.text,
          password: _fields[_RegisterField.Password].controller.text,
        );
      }
      setState(() {});
    }
  }

  void _onHaveAccountTap() {
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
      context.pushLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 32),
          child: Column(
            children: <Widget>[
              TitleView(
                text: context.strings.registration,
                textAlign: TextAlign.center,
                fontSize: 24,
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              Expanded(
                child: ScrollableViewport(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          context.strings.registerNewAccount,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      DefaultField(
                        _fields[_RegisterField.Email],
                        labelText: context.strings.email,
                        nextFocus: _fields[_RegisterField.Name].node,
                      ),
                      DefaultField(
                        _fields[_RegisterField.Name],
                        labelText: context.strings.name,
                        nextFocus: _fields[_RegisterField.Password].node,
                      ),
                      DefaultField(
                        _fields[_RegisterField.Password],
                        labelText: context.strings.password,
                        obscuredText: true,
                        onDone: _onRegisterTap,
                      ),
                      SizedBox(height: 16),
                      _buildButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        AsyncStreamBuilder<void>(
          _bloc.registerSubject.stream,
          onReload: _onRegisterTap,
          initialBuilder: (_) => _buildRegisterButton(),
          failureBuilder: (_, error) => ErrorView(error, onReload: _onRegisterTap, margin: EdgeInsets.all(24)),
        ),
        _buildHaveAnAccountButton(),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: ColoredButton(
        text: context.strings.register,
        onPressed: (_) => _onRegisterTap(),
      ),
    );
  }

  Widget _buildHaveAnAccountButton() {
    return GestureDetector(
      onTap: _onHaveAccountTap,
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Text(
          context.strings.alreadyHaveAccount,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            color: AppColors.of(context).themeUiColor,
          ),
        ),
      ),
    );
  }
}
