import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dark_arch/architecture/utils/async_stream_builder.dart';
import 'package:flutter_dark_arch/architecture/utils/states.dart';
import 'package:flutter_dark_arch/res/app_assets.dart';
import 'package:flutter_dark_arch/res/app_colors.dart';
import 'package:flutter_dark_arch/res/strings.dart';
import 'package:flutter_dark_arch/ui/pages/forgot_password/forgot_password_page_bloc.dart';
import 'package:flutter_dark_arch/ui/pages/register/register_page.dart';
import 'package:flutter_dark_arch/ui/views/buttons/colored_button.dart';
import 'package:flutter_dark_arch/ui/views/error_view.dart';
import 'package:flutter_dark_arch/ui/views/inputs/default_field.dart';
import 'package:flutter_dark_arch/ui/views/inputs/standard_field.dart';
import 'package:flutter_dark_arch/ui/views/language_bar.dart';
import 'package:flutter_dark_arch/ui/views/no_glow_scroll_behavior.dart';
import 'package:flutter_dark_arch/ui/views/title_view.dart';
import 'package:flutter_dark_arch/utils/validator.dart';
import 'package:flutter_dark_arch/utils/validators.dart';

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
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => RegisterPage()),
          (_) => false,
        );
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
          text: Strings.of(context).passwordRestore,
          textAlign: TextAlign.center,
          fontSize: 24,
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            Strings.of(context).receiveYourNewPasswordByEmail,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        DefaultField(
          _fields[_ForgotPasswordField.Email],
          labelText: Strings.of(context).email,
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
        text: Strings.of(context).receiveNewPassword,
        onPressed: (_) => _onRestoreTap(),
      ),
    );
  }
}
