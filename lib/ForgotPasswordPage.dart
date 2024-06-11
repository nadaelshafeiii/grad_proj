// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gp4/PasswordReset.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _checkEmailRegistered() async {
    String email = _emailController.text;
    final Uri url = Uri.parse('http://45.242.245.146:8000/checkemail/');
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },        
        body:jsonEncode({
          'email': email
          }) ,
      );

      if (response.statusCode == 201) {
        json.decode(response.body);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PasswordReset(email:email)),
          );
        setState(() {
        });
      } 
      if(response.statusCode == 400){
                  showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content:  Text('Email is not registered.'.tr),
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
      }
      else {
        throw Exception('Failed to check email registration');
      }
    } catch (error) {
      print('Error: $error');
      // Handle error, show error message or retry option
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 11, 39, 47),
              Color.fromARGB(255, 11, 61, 71),
              Color.fromARGB(255, 10, 117, 135),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Please enter your Email '.tr,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_4, color: Colors.white),
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
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: _checkEmailRegistered,
              child: Container(
                height: 70,
                width: 300,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 22, 139, 159),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [],
                ),
                child:  Center(
                  child: Text(
                    'Set Password'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
