import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_characters/src/app_providers.dart';
import 'package:flutter_marvel_characters/src/app_router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: appProviders,
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: "Marvel Characters",
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
