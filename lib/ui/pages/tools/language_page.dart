import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/res/strings.dart';
import 'package:graduation_work_mobile/res/strings/supported_locale.dart';
import 'package:graduation_work_mobile/ui/views/no_glow_scroll_behavior.dart';
import 'package:graduation_work_mobile/ui/views/scrollable_viewport.dart';
import 'package:graduation_work_mobile/utils/extensions/context.dart';
import 'package:graduation_work_mobile/utils/storage.dart';

class LanguagePage extends StatefulWidget {
  final WidgetBuilder nextPageBuilder;

  const LanguagePage(this.nextPageBuilder);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  void onLocaleTap(SupportedLocale locale) async {
    await Storage().setLanguageCode(locale.languageCode);
    context.pushPage(widget.nextPageBuilder, type: PageTransitionType.Replace);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Text(
                      context.strings.chooseYourLanguage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        color: AppColors.of(context).black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: _buildBody(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: ScrollableViewport(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: SupportedLocale.supportedLocales.map((locale) {
              final languageName = Strings.ofLocale(locale).languageName;
              return FlatButton(
                child: Text(
                  languageName,
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () => onLocaleTap(locale),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
