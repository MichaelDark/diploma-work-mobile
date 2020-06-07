import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api/api_client.dart';
import 'res/app_colors.dart';
import 'ui/pages/auth/forgot_password/forgot_password_page_bloc.dart';
import 'ui/pages/auth/login/login_page_bloc.dart';
import 'ui/pages/auth/register/register_page_bloc.dart';
import 'ui/pages/home/home_page_bloc.dart';
import 'ui/pages/tools/splash_page.dart';
import 'utils/extensions/context.dart';
import 'utils/storage.dart';

class App extends StatelessWidget {
  void _setPortraitOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _setPortraitOnly();
    return BlocProvider(
      blocs: [
        Bloc((i) => RegisterPageBloc(i.get<ApiClient>())),
        Bloc((i) => LoginPageBloc(i.get<ApiClient>())),
        Bloc((i) => ForgotPasswordPageBloc(i.get<ApiClient>())),
        Bloc((i) => HomePageBloc(i.get<ApiClient>())),
      ],
      dependencies: [
        Dependency((Inject i) => ApiClient(context)),
      ],
      child: _buildApp(context),
    );
  }

  Widget _buildApp(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme.apply(
          bodyColor: AppColors.of(context).textColor,
          displayColor: AppColors.of(context).textColor,
        );
    return StreamBuilder<String>(
      stream: Storage().languageCodeStream,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: context.strings.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: AppColors.of(context).themeUiColor,
            scaffoldBackgroundColor: Colors.white,
            textTheme: textTheme.apply(
              fontFamily: 'Montserrat',
            ),
          ),
          home: SplashPage(),
        );
      },
    );
  }
}
