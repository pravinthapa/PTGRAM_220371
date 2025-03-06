import 'package:flutter/material.dart';
import 'package:prabin/common/app/env.dart';
import 'package:prabin/common/app/multi_repositroy.dart';
import 'package:prabin/common/app/multibloc_wrapper.dart';
import 'package:prabin/common/app/themes.dart' as CustomTheme;
import 'package:prabin/common/navigation/navigation_service.dart';
import 'package:prabin/common/route/route.dart';
import 'package:prabin/common/route/routing.dart';

class App extends StatelessWidget {
  final Env env;
  const App({super.key, required this.env});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryWrapper(
      env: env,
      child: MultiBlocWrapper(
        env: env,
        child: MaterialApp(
          navigatorKey: NavigationService.navigationKey,
          theme: CustomTheme.lightTheme,
          initialRoute: Routes.root,
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
