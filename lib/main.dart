import 'package:flutter/material.dart';
import 'package:flutter_marvel_characters/src/app_widget.dart';
import 'package:flutter_marvel_characters/src/sl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  initServiceLocator();
  runApp(const AppWidget());
}
