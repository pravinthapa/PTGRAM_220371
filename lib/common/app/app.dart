import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:ptgram/common/app/env.dart';
import 'package:ptgram/common/app/multi_repositroy.dart';
import 'package:ptgram/common/app/multibloc_wrapper.dart';
import 'package:ptgram/common/app/theme.dart';
import 'package:ptgram/common/navigation/navigation_service.dart';
import 'package:ptgram/common/route/route.dart';
import 'package:ptgram/common/route/routing.dart';

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
