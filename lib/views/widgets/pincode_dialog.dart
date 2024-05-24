import 'package:flutter/material.dart';
import 'package:simple_project/controllers/app_constant.dart';
import 'package:simple_project/views/screens/settings_screen.dart';

class PinCodeDialog extends StatefulWidget {
  final ValueChanged<bool> onAuthenticated;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onLanguageChanged;

  const PinCodeDialog(
      {required this.onAuthenticated,
      required this.onLanguageChanged,
      required this.onThemeChanged,
      Key? key})
      : super(key: key);

  @override
  PinCodeDialogState createState() => PinCodeDialogState();
}

class PinCodeDialogState extends State<PinCodeDialog> {
  final _pinController = TextEditingController();

  void _checkPin() {
    if (_pinController.text == AppConstant.pinCode) {
      widget.onAuthenticated(true);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) {
            return SettingsScreen(
                onThemeChanged: widget.onThemeChanged,
                onLanguageChanged: widget.onLanguageChanged);
          },
        ),
      );
    } else {
      widget.onAuthenticated(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bunday parol mavjud emas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('PIN kodni kiriting'),
      content: TextField(
        controller: _pinController,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        decoration: const InputDecoration(
          hintText: 'PIN kod',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Bekor qilish'),
        ),
        ElevatedButton(
          onPressed: _checkPin,
          child: const Text('Tasdiqlash'),
        ),
      ],
    );
  }
}
