import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> saveString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", AppConstant.language);
    await prefs.setString("pinCode", AppConstant.pinCode);
    await prefs.setString("themeMode", AppConstant.themeMode.toString());
    await prefs.setString("appColor", AppConstant.appColor.toString());
    await prefs.setString(
        "backgroundColor", AppConstant.backgroundColor.toString());
    setState(() {});
  }

  Future<void> getString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.getString("language");
    await prefs.getString("pinCode");
    await prefs.getString("themeMode");
    await prefs.getString("appColor");
    await prefs.getString("backgroundColor");

    print(prefs.getString("language"));
    print(prefs.getString("pinCode"));
    print(prefs.getString("themeMode"));
    print(prefs.getString("appColor"));
    print(prefs.getString("backgroundColor"));
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
