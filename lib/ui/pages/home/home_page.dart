import 'package:flutter/material.dart';
import 'package:flutter_dark_arch/res/strings.dart';
import 'package:flutter_dark_arch/ui/pages/_example/test/test_page.dart';
import 'package:flutter_dark_arch/ui/pages/register/register_page.dart';
import 'package:flutter_dark_arch/ui/views/language_bar.dart';
import 'package:flutter_dark_arch/ui/views/no_glow_scroll_behavior.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void _onLogoutTap() async {
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
            _buildLanguageBar(),
            Expanded(
              child: _buildQuestMetaList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                Strings.of(context).logout,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            onTap: () => _onLogoutTap(),
          ),
          LanguageBar(),
        ],
      ),
    );
  }

  Widget _buildQuestMetaList() {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          RaisedButton(
            child: Text('Test Page 1'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => TestPage()));
            },
          )
        ],
      ),
    );
  }
}
