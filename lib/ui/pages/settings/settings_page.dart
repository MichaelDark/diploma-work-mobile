import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/res/strings.dart';
import 'package:graduation_work_mobile/ui/pages/register/register_page.dart';
import 'package:graduation_work_mobile/ui/views/header.dart';
import 'package:graduation_work_mobile/ui/views/no_glow_scroll_behavior.dart';
import 'package:graduation_work_mobile/utils/storage.dart';

import 'views/language_option.dart';
import 'views/option_separator.dart';
import 'views/text_option.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _onLogout() async {
    await Storage().setUserEmail(null);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => RegisterPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Header(
              title: Strings.of(context).settings,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: ListView(
                  children: <Widget>[
                    LanguageOption(),
                    OptionSeparator(),
                    TextOption(
                      text: Strings.of(context).logout,
                      onPressed: _onLogout,
                    ),
                    OptionSeparator(),
                    TextOption(
                      text: Strings.of(context).logout,
                      onPressed: _onLogout,
                    ),
                    OptionSeparator(),
                    TextOption(
                      text: Strings.of(context).logout,
                      onPressed: _onLogout,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
