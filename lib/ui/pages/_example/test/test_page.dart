import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/architecture/utils/async_stream_builder.dart';
import 'package:graduation_work_mobile/architecture/utils/async_subject_builder.dart';
import 'package:graduation_work_mobile/models/home_item.dart';
import 'package:graduation_work_mobile/res/strings/supported_locale.dart';
import 'package:graduation_work_mobile/ui/pages/register/register_page.dart';
import 'package:graduation_work_mobile/ui/views/error_view.dart';
import 'package:graduation_work_mobile/ui/views/language_bar.dart';
import 'package:graduation_work_mobile/ui/views/no_glow_scroll_behavior.dart';

import 'test_page_bloc.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TestPageBloc _bloc = BlocProvider.getBloc<TestPageBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.loadHomeItems();
  }

  void _onNewLanguageSelected(SupportedLocale locale) async {
//    _bloc.loadHomeItems();
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
              child: _buildBody(),
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
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          LanguageBar(
            onLanguageChanged: _onNewLanguageSelected,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return AsyncStreamBuilder<List<HomeItem>>(
      _bloc.homeItemSubject.stream,
      initialBuilder: (_) => Container(),
      successBuilder: (_, value) => _buildQuestMetaList(value),
      failureBuilder: (_, error) => ErrorView(error, onReload: () => _bloc.loadHomeItems()),
    );
  }

  Widget _buildQuestMetaList(List<HomeItem> data) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehavior(),
      child: ListView(
        padding: EdgeInsets.all(20),
        children: data.map((HomeItem homeItem) {
          return _buildHomeItemAsync(homeItem);
        }).toList(),
      ),
    );
  }

  Widget _buildHomeItemAsync(HomeItem homeItem) {
    return Container(
      height: 128,
      child: AsyncSubjectBuilder<HomeItem>(
        _bloc.loadHomeItemById(homeItem.id),
        initialBuilder: (_) => Text('initial homeItem'),
        successBuilder: (_, value) => _buildHomeItemSync(value),
        failureBuilder: (_, error) => ErrorView(error, onReload: () => _bloc.loadHomeItems()),
      ),
    );
  }

  Widget _buildHomeItemSync(HomeItem homeItem) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text('${homeItem.id}'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text('${homeItem.title}'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text('${homeItem.description}'),
          ),
        ],
      ),
    );
  }
}
