import 'package:flutter/material.dart';
import 'package:graduation_work_mobile/res/app_colors.dart';
import 'package:graduation_work_mobile/ui/views/no_glow_scroll_behavior.dart';
import 'package:graduation_work_mobile/ui/views/scrollable_viewport.dart';
import 'package:graduation_work_mobile/utils/extensions/context.dart';
import 'package:graduation_work_mobile/utils/extensions/permissions.dart';

class PermissionsPage extends StatefulWidget {
  final WidgetBuilder nextPageBuilder;

  const PermissionsPage(this.nextPageBuilder);

  @override
  _PermissionsPageState createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  void onPermissionsGranted() {
    context.pushPage(widget.nextPageBuilder, type: PageTransitionType.Replace);
  }

  void onRequestPermissions() async {
    if (await checkAppPermissions()) {
      onPermissionsGranted();
    }
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
                      context.strings.giveNeededPermissions,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.of(context).black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: _buildBody(),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: RaisedButton(
                child: Text(context.strings.giveNeededPermissions),
                onPressed: () => onRequestPermissions(),
              ),
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
            children: [
              Text(
                context.strings.permissionsReason,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
