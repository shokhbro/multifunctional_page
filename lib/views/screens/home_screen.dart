import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_project/controllers/app_constant.dart';
import 'package:simple_project/views/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onLanguageChanged;

  const HomeScreen({
    required this.onThemeChanged,
    required this.onLanguageChanged,
    super.key,
  });

  Future<void> saveString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", AppConstant.language);
  }

  Future<String?> getString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", AppConstant.language);
    return prefs.getString("language");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Home Screen",
          style: TextStyle(
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          DropdownButton<String>(
            value: AppConstant.language,
            onChanged: (String? newValue) {
              if (newValue != null) {
                onLanguageChanged(newValue);
              }
            },
            items: <String>['en', 'ru', 'uz']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      drawer: CustomDrawer(
        onThemeMode: onThemeChanged,
        onLanguageMode: onLanguageChanged,
      ),
    );
  }
}
