import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/ui/views/language_bar.dart';
import 'package:graduation_work_mobile/ui/views/no_glow_scroll_behavior.dart';
import 'package:graduation_work_mobile/utils/extensions/context.dart';
import 'package:graduation_work_mobile/utils/storage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Text(
                    context.strings.settings,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.of(context).black,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 32, right: 8),
                      title: Text(
                        context.strings.interfaceLanguage,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: LanguageBar(),
                    ),
                    _buildSeparator(),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 32),
                      title: Text(
                        context.strings.logout,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () async {
                        await Storage().setUserEmail(null);
                        context.pushLogOut();
                      },
                    ),
                    _buildSeparator(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      height: 1,
      color: Colors.grey,
    );
  }
}
