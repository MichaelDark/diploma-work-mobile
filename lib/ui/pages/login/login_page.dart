import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/architecture/utils/async_stream_builder.dart';
import 'package:graduation_work_mobile/architecture/utils/states.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/res/strings.dart';
import 'package:graduation_work_mobile/ui/pages/forgot_password/forgot_password_page.dart';
import 'package:graduation_work_mobile/ui/pages/home/home_page.dart';
import 'package:graduation_work_mobile/ui/pages/login/login_page_bloc.dart';
import 'package:graduation_work_mobile/ui/views/buttons/colored_button.dart';
import 'package:graduation_work_mobile/ui/views/error_view.dart';
import 'package:graduation_work_mobile/ui/views/inputs/default_field.dart';
import 'package:graduation_work_mobile/ui/views/inputs/standard_field.dart';
import 'package:graduation_work_mobile/ui/views/no_glow_scroll_behavior.dart';
import 'package:graduation_work_mobile/ui/views/title_view.dart';
import 'package:graduation_work_mobile/utils/storage.dart';
import 'package:graduation_work_mobile/utils/validator.dart';
import 'package:graduation_work_mobile/utils/validators.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum _LoginField { Email, Password }

class _LoginPageState extends State<LoginPage> {
  LoginPageBloc _bloc = BlocProvider.getBloc<LoginPageBloc>();
  Map<_LoginField, FieldData> _fields = Map.fromIterable(
    _LoginField.values,
    key: (f) => f,
    value: (f) => FieldData(),
  );

  @override
  void initState() {
    super.initState();
    _bloc.loginSubject.listen((dynamic state) async {
      if (mounted && state is SuccessState<String>) {
        await Storage().setUserEmail(state.data);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomePage()),
          (_) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.loginSubject.value = null;
  }

  void _onLoginTap() async {
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
      final validator = Validator()
        ..add<String, String>(
          data: _fields[_LoginField.Email].controller.text,
          onValidate: getEmailValidation(context),
          onValid: (_) => _fields[_LoginField.Email].errorText = null,
          onInvalid: (String errorText) => _fields[_LoginField.Email].errorText = errorText,
        )
        ..add<String, String>(
          data: _fields[_LoginField.Password].controller.text,
          onValidate: getPasswordValidation(context),
          onValid: (_) => _fields[_LoginField.Password].errorText = null,
          onInvalid: (String errorText) => _fields[_LoginField.Password].errorText = errorText,
        );
      if (validator.validate()) {
        _bloc.login(
          _fields[_LoginField.Email].controller.text,
          _fields[_LoginField.Password].controller.text,
        );
      }
      setState(() {});
    }
  }

  void _onForgotPasswordTap() {
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
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
          text: Strings.of(context).signIn,
          textAlign: TextAlign.center,
          fontSize: 24,
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            Strings.of(context).logInWithExistingAccount,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        DefaultField(
          _fields[_LoginField.Email],
          labelText: Strings.of(context).email,
          nextFocus: _fields[_LoginField.Password].node,
        ),
        DefaultField(
          _fields[_LoginField.Password],
          labelText: Strings.of(context).password,
          obscuredText: true,
          onDone: _onLoginTap,
        ),
        SizedBox(height: 16),
        _buildButtons(),
      ],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        AsyncStreamBuilder<void>(
          _bloc.loginSubject.stream,
          onReload: _onLoginTap,
          initialBuilder: (_) => _buildLoginButton(),
          failureBuilder: (_, error) => ErrorView(error, onReload: _onLoginTap, margin: EdgeInsets.all(24)),
        ),
        _buildForgotPasswordButton(),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: ColoredButton(
        text: Strings.of(context).signIn,
        onPressed: (_) => _onLoginTap(),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return GestureDetector(
      onTap: _onForgotPasswordTap,
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Text(
          Strings.of(context).iForgotPassword,
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
