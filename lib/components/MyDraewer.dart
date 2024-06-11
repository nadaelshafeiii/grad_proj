import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gp4/HelpCenter.dart';
import 'package:gp4/LoginPage.dart';
import 'package:gp4/aboutus.dart';
import 'package:gp4/auth_utlis.dart';
import 'package:gp4/landingpage.dart';
import 'package:gp4/local/localecontroller.dart';
import 'package:gp4/profile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Map<String, String> permissionStatus = {
    'Camera': 'Unknown',
    'Notification': 'Unknown',
    'Location': 'Unknown',
  };
  bool cameraPermissionAllowed = false;

  Map<String, dynamic>? userData;

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
  void initState() {
    super.initState();
    _checkPermissions();
    fetchUserData();
  }

  Future<void> _checkPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final notificationStatus = await Permission.notification.status;
    final locationStatus = await Permission.location.status;
    setState(() {
      cameraPermissionAllowed = cameraStatus.isGranted;
      permissionStatus['Camera'.tr] =
          cameraStatus.isGranted ? 'Allowed'.tr : 'Not Allowed'.tr;
      permissionStatus['Notification'.tr] =
          notificationStatus.isGranted ? 'Allowed'.tr : 'Not Allowed'.tr;
      permissionStatus['Location'.tr] =
          locationStatus.isGranted ? 'Allowed'.tr : 'Not Allowed'.tr;
    });
    if (cameraStatus.isDenied) {
      await Permission.camera.request().then((status) {
        setState(() {
          cameraPermissionAllowed = status.isGranted;
          permissionStatus['Camera'.tr] =
              status.isGranted ? 'Allowed'.tr : 'Not Allowed'.tr;
        });
      });
    }
    if (notificationStatus.isDenied) {
      await Permission.notification.request().then((status) {
        setState(() {
          permissionStatus['Notification'.tr] =
              status.isGranted ? 'Allowed'.tr : 'Not Allowed'.tr;
        });
      });
    }
    if (locationStatus.isDenied) {
      await Permission.location.request().then((status) {
        setState(() {
          permissionStatus['Location'.tr] =
              status.isGranted ? 'Allowed'.tr : 'Not Allowed'.tr;
        });
      });
    }
  }

  void _openAppSettings() {
    openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    MyLocaleController controllerLang = Get.find();

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: userData != null
                ? Text(userData?['username'] ?? 'Username')
                : Text('Username'.tr),
            accountEmail: userData != null
                ? Text(userData?['email'] ?? 'Email')
                : Text('Email'.tr),
            currentAccountPicture: const CircleAvatar(
              child: Icon(
                Icons.person,
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 21, 74, 82),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('My Profile'.tr),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),

          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('About Us'.tr),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('Help Center'.tr),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HelpCenterPage()));
            },
          ),
          ExpansionTile(
            title: Text('Change Language'.tr),
            children: [
              ListTile(
                title: Text('English'.tr),
                onTap: () {
                  controllerLang.changeLang("en");
                },
              ),
              ListTile(
                title: const Text('العربية'),
                onTap: () {
                  controllerLang.changeLang("ar");
                },
              ),
        //     ListTile(
        //       title: Text('Open Camera'.tr),
        //       onTap: () async {
        //       WidgetsFlutterBinding.ensureInitialized();
        //       final cameras = await availableCameras();
        //       final firstCamera = cameras.firstWhere(
        //               (camera) => camera.lensDirection == CameraLensDirection.front
        //       );
        //       Navigator.of(context as BuildContext).pushReplacement(
        //           MaterialPageRoute(builder: (context) => CameraPage(camera: firstCamera, cameraPermissionAllowed: true,),)
        //     );
        // }),
            ],
          ),
          ExpansionTile(
            title: Text('Privacy and Security'.tr),
            children: [
              PermissionItem(
                permission: 'Camera'.tr,
                status: permissionStatus['Camera']!,
                onPressed: _openAppSettings,
              ),
              PermissionItem(
                permission: 'Notification'.tr,
                status: permissionStatus['Notification']!,
                onPressed: _openAppSettings,
              ),
              PermissionItem(
                permission: 'Location'.tr,
                status: permissionStatus['Location']!,
                onPressed: _openAppSettings,
              ),

            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                logout(context);
              },
              child: Container(
                height: 60,
                width: 110,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 22, 139, 159),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [],
                ),
                child: Center(
                  child: Text(
                    'Log out'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PermissionItem extends StatelessWidget {
  final String permission;
  final String status;
  final VoidCallback onPressed;

  PermissionItem({
    required this.permission,
    required this.status,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$permission Permission: $status'),
      trailing: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: onPressed,
      ),
    );
  }
}
