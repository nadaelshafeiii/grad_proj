// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gp4/EditProfile.dart';
import 'package:gp4/LoginPage.dart';
import 'package:gp4/landingpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    String? token = await AuthService.getToken();
    var response = await http.get(
      Uri.parse('http://45.242.245.146:8000/currentuserdetails/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body);
        print(token);
      });
    } else {
      print('Failed to fetch user data');
    }
  }

  Future<void> deleteAccount() async {
    String? token = await AuthService.getToken();
    var response = await http.get(
      Uri.parse('http://45.242.245.146:8000/deleteaccount/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account deleted successfully')),
      );
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => landingpage(),
      ),
    );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete account')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 21, 74, 82),
              Color.fromARGB(255, 10, 30, 37),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 100.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Profile'.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              const SizedBox(
                  height:
                      20), // Add spacing between username/icon and user details
              if (userData != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        color: Colors.white,
                        height: 10,
                        thickness: 1.5,
                        indent: 0,
                        endIndent: 0,
                      ),
                      const SizedBox(height: 40),

                      
    Container(
      padding: EdgeInsets.all(8.0), // Padding around the text
      decoration: BoxDecoration(
        color: Colors.transparent, // Background color
        border: Border.all(
          color: Colors.white, // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Text(
        'Email: ${userData?['email']}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          decoration: TextDecoration.none,
        ),
      ),
    ),

    const SizedBox(height: 20,),

    Container(
      padding: EdgeInsets.all(8.0), // Padding around the text
      decoration: BoxDecoration(
        color: Colors.transparent, // Background color
        border: Border.all(
          color: Colors.white, // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Text(
        'username: ${userData?['username']}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          decoration: TextDecoration.none,
        ),
      ),
    ),
    
        const SizedBox(height: 20,),

    Container(
      padding: EdgeInsets.all(8.0), // Padding around the text
      decoration: BoxDecoration(
        color: Colors.transparent, // Background color
        border: Border.all(
          color: Colors.white, // Border color
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Text(
        'Emergency Email: ${userData?['emergency_email']}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          decoration: TextDecoration.none,
        ),
      ),
    ),

                      const SizedBox(height: 50),
                      Center(
                        child: SizedBox(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(
                                    email: userData?['email'],
                                    username: userData?['username'],
                                    emergency_email: userData?['emergency_email'],
                                    password: userData?['password'] ?? '******',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            ),
                            child: const Text('Edit ',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              deleteAccount();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            ),
                            child: const Text('Delete\nAccount ',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 110),
                      const Padding(
                        padding: EdgeInsets.only(left: 170.0),
                        child: Icon(
                          FontAwesomeIcons.truckFast,
                          size: 135,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
