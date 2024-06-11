import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp4/LoginPage.dart';
import 'package:http/http.dart' as http;

class PasswordReset extends StatefulWidget {
  final String email;
  final Key? key;

  PasswordReset({required this.email, this.key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isVisible = true;

  Future<void> _changePassword() async {
    String newPassword = _passwordController.text;
    String confirmedPassword = _confirmPasswordController.text;

    if (newPassword != confirmedPassword) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Passwords do not match.'.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final Uri url = Uri.parse('http://45.242.245.146:8000/resetpassword/');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'new_password': newPassword,
          'email': widget.email,
        }),
      );

      if (response.statusCode == 201) {
        print('Success');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        throw Exception('Failed to change password'.tr);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 21, 74, 82),
              Color.fromARGB(255, 10, 30, 37),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 180),
                Padding(
                  padding: const EdgeInsets.only(right: 220.0),
                  child: Text(
                    'Password'.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _isVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: Icon(
                          _isVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(22, 139, 159, 0.867), width: 7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(22, 139, 159, 0.867), width: 7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(22, 139, 159, 0.867), width: 7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(right: 170),
                  child: Text(
                    'Confirm password'.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _isVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: Icon(
                          _isVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(22, 139, 159, 0.867), width: 7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(22, 139, 159, 0.867), width: 7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(22, 139, 159, 0.867), width: 7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  height: 60,
                  width: 270,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 22, 139, 159),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextButton(
                    onPressed: _changePassword,
                    child:  Text(
                      'Reset Password'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
