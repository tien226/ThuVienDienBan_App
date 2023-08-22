import 'package:app/config_network/main_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'auto_route/auto_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MainModul.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [AutoRouteObserver()]
      ),
    );
  }
}

