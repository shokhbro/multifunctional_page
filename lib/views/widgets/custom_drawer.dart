import 'package:flutter/material.dart';
import 'package:simple_project/views/screens/home_screen.dart';
import 'package:simple_project/views/screens/settings_screen.dart';
import 'package:simple_project/views/widgets/pincode_dialog.dart';

class CustomDrawer extends StatelessWidget {
  final ValueChanged<bool> onThemeMode;
  final ValueChanged<String> onLanguageMode;

  const CustomDrawer({
    required this.onThemeMode,
    required this.onLanguageMode,
    super.key,
  });

  void _showPinCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return PinCodeDialog(
          onLanguageChanged: onLanguageMode,
          onThemeChanged: onThemeMode,
          onAuthenticated: (isAuthenticated) {
            if (isAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => SettingsScreen(
                    onThemeChanged: onThemeMode,
                    onLanguageChanged: onLanguageMode,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Menu",
                  style: TextStyle(
                    fontFamily: 'Lato',
                  ),
                ),
                Text(
                  "Hotel",
                  style: TextStyle(
                    fontFamily: 'Lato',
                  ),
                ),
                Text(
                  "Motel",
                  style: TextStyle(
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () => _showPinCodeDialog(context),
            title: const Text(
              "Settings",
              style: TextStyle(
                fontFamily: 'Lato',
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (ctx) {
                return HomeScreen(
                  onThemeChanged: onThemeMode,
                  onLanguageChanged: onLanguageMode,
                );
              }));
            },
            title: const Text(
              "Home Page",
              style: TextStyle(
                fontFamily: 'Lato',
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}
