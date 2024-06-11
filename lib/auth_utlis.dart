import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gp4/loginpage.dart';
import 'main.dart';

Future<void> logout(BuildContext context) async {
  // Delete the token from secure storage
  await AuthService.deleteToken();

  // Clear the token in the app state
  Provider.of<TokenProvider>(context, listen: false).deleteToken();

  // Navigate to login page
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
    (Route<dynamic> route) => false,
  );
}
