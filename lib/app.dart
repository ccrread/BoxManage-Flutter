import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_router.dart';

final appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: '盒子管理系统',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: appRouter.config(),
      ),
    );
  }
}