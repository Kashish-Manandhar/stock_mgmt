import 'package:flutter/material.dart';
import 'package:stock_management/core/auto_route/app_router.dart';
import 'package:stock_management/core/di/injector.dart';
final _appRouter = getIt<AppRouter>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),

    );
  }
}
