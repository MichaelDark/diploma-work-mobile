import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dark_arch/architecture/utils/async_stream_builder.dart';
import 'package:flutter_dark_arch/architecture/utils/states.dart';
import 'package:flutter_dark_arch/res/app_assets.dart';
import 'package:flutter_dark_arch/res/app_colors.dart';
import 'package:flutter_dark_arch/res/strings.dart';
import 'package:flutter_dark_arch/ui/pages/forgot_password/forgot_password_page.dart';
import 'package:flutter_dark_arch/ui/pages/home/home_page.dart';
import 'package:flutter_dark_arch/ui/pages/login/login_page_bloc.dart';
import 'package:flutter_dark_arch/ui/views/buttons/colored_button.dart';
import 'package:flutter_dark_arch/ui/views/error_view.dart';
import 'package:flutter_dark_arch/ui/views/inputs/default_field.dart';
import 'package:flutter_dark_arch/ui/views/inputs/standard_field.dart';
import 'package:flutter_dark_arch/ui/views/language_bar.dart';
import 'package:flutter_dark_arch/ui/views/no_glow_scroll_behavior.dart';
import 'package:flutter_dark_arch/ui/views/title_view.dart';
import 'package:flutter_dark_arch/utils/storage.dart';
import 'package:flutter_dark_arch/utils/validator.dart';
import 'package:flutter_dark_arch/utils/validators.dart';

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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.of(context).blackOp50,
                    blurRadius: 10,
                    offset: Offset.zero,
                  ),
                ],
              ),
              margin: EdgeInsets.all(24),
              padding: EdgeInsets.all(12),
              child: _buildBodyColumn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.all(16),
          icon: Icon(Icons.arrow_back),
        ),
        LanguageBar(),
      ],
    );
  }

  Widget _buildBodyColumn() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset(
            AppAssets.icLogo,
            height: 64,
          ),
        ),
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
        padding: EdgeInsets.all(12),
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
