import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


Future<Map<String, dynamic>> tryfetchUserData(int id) async {
  final response = await http.get(Uri.parse('https://reqres.in/api/users/2'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load user data');
  }
}


class UserDetailScreen extends StatelessWidget {
  final int id;
  final String pageName;

  UserDetailScreen({required this.id, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName), // Use the pageName as the title
      ),
      body: FutureBuilder(
        future: tryfetchUserData(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Loading indicator
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final userData = snapshot.data?['data']; // Access user data under the "data" key
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${userData['id']}'),
                  Text('First Name: ${userData['first_name']}'), // Use "first_name" instead of "username"
                  Text('Last Name: ${userData['last_name']}'), // Access "last_name" instead of "username"
                  Text('Email: ${userData['email']}'),
                  // Add other fields as needed
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
