import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Marvel Characters",
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text("Marvel Characters App"),
        ),
      ),
    );
  }
}
