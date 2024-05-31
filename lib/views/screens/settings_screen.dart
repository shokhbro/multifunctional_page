import 'package:flutter/material.dart';
import 'package:simple_project/controllers/app_constant.dart';
import 'package:simple_project/views/widgets/custom_drawer.dart';
import 'package:simple_project/views/widgets/pincode_dialog.dart';

class SettingsScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onLanguageChanged;

  const SettingsScreen({
    required this.onThemeChanged,
    required this.onLanguageChanged,
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final controller = TextEditingController();

  void _changePin() {
    if (_newPinController.text == _confirmPinController.text) {
      setState(() {
        AppConstant.pinCode = _newPinController.text;
      });
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN kodlar mos emas')),
      );
    }
  }

  void _showChangePinDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('PIN kodni o\'zgartirish'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _newPinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                decoration: const InputDecoration(
                  hintText: 'Yangi PIN kod',
                ),
              ),
              TextField(
                controller: _confirmPinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                decoration: const InputDecoration(
                  hintText: 'PIN kodni tasdiqlash',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Bekor qilish'),
            ),
            ElevatedButton(
              onPressed: _changePin,
              child: const Text('Saqlash'),
            ),
          ],
        );
      },
    );
  }

  void _showCurrentPinDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return PinCodeDialog(
          onLanguageChanged: widget.onLanguageChanged,
          onThemeChanged: widget.onThemeChanged,
          onAuthenticated: (isAuthenticated) {
            if (isAuthenticated) {
              _showChangePinDialog();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        // backgroundColor: AppConstant.appColor,
        centerTitle: true,
        title: const Text(
          "Setting Screen",
          style: TextStyle(
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          DropdownButton<String>(
            value: AppConstant.language,
            onChanged: (String? newValue) {
              if (newValue != null) {
                widget.onLanguageChanged(newValue);
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
          IconButton(
            icon: const Icon(Icons.lock),
            onPressed: _showCurrentPinDialog,
          ),
        ],
      ),
      drawer: CustomDrawer(
        onThemeMode: widget.onThemeChanged,
        onLanguageMode: widget.onLanguageChanged,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: AppConstant.themeMode == ThemeMode.dark,
            onChanged: widget.onThemeChanged,
            title: const Text(
              "Tungi rejim",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Lato",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
