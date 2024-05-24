import 'package:flutter/material.dart';
import 'package:simple_project/controllers/app_constant.dart';
import 'package:simple_project/views/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void toggleTheme(bool value) {
    AppConstant.themeMode = value ? ThemeMode.dark : ThemeMode.light;
    setState(() {});
  }

  void changeBackgroundColor(Color color) {
    AppConstant.backgroundColor = color;
    setState(() {});
  }

  void changeLanguage(String lang) {
    AppConstant.language = lang;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: AppConstant.themeMode,
      home: HomeScreen(
        onThemeChanged: toggleTheme,
        onLanguageChanged: changeLanguage,
      ),
    );
  }
}
