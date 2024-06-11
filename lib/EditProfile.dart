import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gp4/LoginPage.dart';
import 'package:gp4/auth_utlis.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  final String email;
  final String username;
  final String emergency_email;
  final String password;

  // Constructor
  const EditProfilePage({
    Key? key,
    required this.email,
    required this.username,
    required this.emergency_email,
    required this.password,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showAdditionalFields = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emergency_emailController =TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  // Unique GlobalKey for Form widget
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
    usernameController.text = widget.username;
    emergency_emailController.text = widget.emergency_email;
  }

  void saveUpdatedData() async {
    String? token = await AuthService.getToken();

    // Example API endpoint for updating user data
    Uri apiUrl = Uri.parse('http://45.242.245.146:8000/updateprofile/');
    try {
      var response = await http.put(
        apiUrl,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
        body: jsonEncode({
          'email': emailController.text,
          'username': usernameController.text,
          'phone_number': emergency_emailController.text,
          'old_password': oldPasswordController.text,
          'password': newPasswordController.text,
        }),
      );
      if (response.statusCode == 201) {
        print('User data updated successfully');
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text('User data updated successfully'.tr),
          backgroundColor: Colors.green,
        ));

      } 
      else if (response.statusCode == 400) {
        print('Failed to update user data');
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text('Failed to update user data'.tr),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 404) {
        print('Wrong Password');
        //scaffoldMessenger.of(context).showSnackBar( SnackBar(
        //  content: Text('Wrong Password'.tr),
          //backgroundColor: Colors.red,
        //));
      } else {
        print('Unexpected error: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text('Unexpected error occurred'.tr),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print('Error updating user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error updating user data'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assigning unique GlobalKey to Form
            child: Column(
              children: [
              
              Row(
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
                    padding: const EdgeInsets.only(left:320.0),
                    child: IconButton(
                    icon: const Icon(Icons.logout_rounded ,color: Colors.white),
                    onPressed: () => logout(context), // Call logout function
                  ),
                  ),
                ],
              ),
                Row(
                  children:  [
                    const SizedBox(
                      width: 50,
                    ),
                    const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Profile'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),

                const Divider(
                  color: Colors.white,
                  height: 10,
                  thickness: 1.5,
                  indent: 50,
                  endIndent: 50,
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email'.tr,
                          prefixIcon:
                              const Icon(Icons.person_4, color: Colors.white),
                          fillColor: Colors.transparent,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(22, 139, 159, 0.867),
                                width: 7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(22, 139, 159, 0.867),
                                width: 7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(22, 139, 159, 0.867),
                                width: 7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: 'username'.tr,
                          hintStyle: const TextStyle(color: Colors.white), // Change the hint text color
                          prefixIcon:
                              const Icon(Icons.person_4, color: Colors.white),
                          fillColor: Colors.transparent,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(22, 139, 159, 0.867),
                                width: 7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(22, 139, 159, 0.867),
                                width: 7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(22, 139, 159, 0.867),
                                width: 7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Stack(
                      children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: TextFormField(
                readOnly: true, // Make the text field read-only
                obscureText: !showAdditionalFields,
                style: const TextStyle(
                  color: Colors.white, // Change the text color
                ),
                decoration: InputDecoration(
                  hintText: 'password'.tr,
                  hintStyle: const TextStyle(color: Colors.white), // Change the hint text color
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showAdditionalFields = !showAdditionalFields;
                      });
                    },
                    child: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
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

                        if (showAdditionalFields)
                          Column(
                            children: [
                              const SizedBox(height: 70),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                                child: TextFormField(
                                  controller: oldPasswordController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter old password'.tr,
                                    hintStyle: const TextStyle(color: Colors.white), // Change the hint text color
                                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(22, 139, 159, 0.867),
                                          width: 7),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(22, 139, 159, 0.867),
                                          width: 7),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(22, 139, 159, 0.867),
                                          width: 7),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                                child: TextFormField(
                                  controller: newPasswordController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter new password'.tr,
                  hintStyle: const TextStyle(color: Colors.white), // Change the hint text color
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(22, 139, 159, 0.867),
                                          width: 7),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(22, 139, 159, 0.867),
                                          width: 7),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(22, 139, 159, 0.867),
                                          width: 7),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: TextFormField(
                        controller: emergency_emailController,
                        decoration: InputDecoration(
                          hintText: 'Emergency contact'.tr,
                          prefixIcon:
                              const Icon(Icons.person_4, color: Colors.white),
                          fillColor: Colors.transparent,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(22, 139, 159, 0.867),
                                width: 7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(22, 139, 159, 0.867),
                                width: 7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(22, 139, 159, 0.867),
                                width: 7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: SizedBox(
                    width: 130,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            saveUpdatedData();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                        child:  Text(
                          'Save'.tr,
                          style: const TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 200.0),
                  child: Icon(
                    FontAwesomeIcons.truck,
                    size: 100,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
