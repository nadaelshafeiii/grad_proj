// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:camera/camera.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Permission Handler',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PermissionHandlerPage(),
//     );
//   }
// }

// class PermissionHandlerPage extends StatefulWidget {
//   @override
//   _PermissionHandlerPageState createState() => _PermissionHandlerPageState();
// }

// class _PermissionHandlerPageState extends State<PermissionHandlerPage> {
//   Map<String, String> permissionStatus = {
//     'Camera': 'Unknown',
//     'Notification': 'Unknown',
//     'Location': 'Unknown',
//   };
//   bool cameraPermissionAllowed = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkPermissions();
//   }

//   Future<void> _checkPermissions() async {
//     final cameraStatus = await Permission.camera.status;
//     final notificationStatus = await Permission.notification.status;
//     final locationStatus = await Permission.location.status;

//     setState(() {
//       permissionStatus['Camera'] = cameraStatus.isGranted ? 'Allowed' : 'Not Allowed';
//       permissionStatus['Notification'] = notificationStatus.isGranted ? 'Allowed' : 'Not Allowed';
//       permissionStatus['Location'] = locationStatus.isGranted ? 'Allowed' : 'Not Allowed';
//       cameraPermissionAllowed = cameraStatus.isGranted;
//     });

//     if (cameraStatus.isDenied) {
//       await Permission.camera.request().then((status) {
//         setState(() {
//           cameraPermissionAllowed = status.isGranted;
//           permissionStatus['Camera'] = status.isGranted ? 'Allowed' : 'Not Allowed';
//         });
//       });
//     }
//     if (notificationStatus.isDenied) {
//       await Permission.notification.request().then((status) {
//         setState(() {
//           permissionStatus['Notification'] = status.isGranted ? 'Allowed' : 'Not Allowed';
//         });
//       });
//     }
//     if (locationStatus.isDenied) {
//       await Permission.location.request().then((status) {
//         setState(() {
//           permissionStatus['Location'] = status.isGranted ? 'Allowed' : 'Not Allowed';
//         });
//       });
//     }
//   }

//   void _openAppSettings() {
//     openAppSettings();
//   }

//   void _openCameraPage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CameraPage(cameraPermissionAllowed: cameraPermissionAllowed),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Permission Handler'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             PermissionItem(
//               permission: 'Camera',
//               status: permissionStatus['Camera']!,
//               onPressed: _openAppSettings,
//             ),
//             PermissionItem(
//               permission: 'Notification',
//               status: permissionStatus['Notification']!,
//               onPressed: _openAppSettings,
//             ),
//             PermissionItem(
//               permission: 'Location',
//               status: permissionStatus['Location']!,
//               onPressed: _openAppSettings,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: cameraPermissionAllowed ? _openCameraPage : null,
//         tooltip: 'Open Camera Page',
//         child: Icon(Icons.camera_alt),
//       ),
//     );
//   }
// }

// class PermissionItem extends StatelessWidget {
//   final String permission;
//   final String status;
//   final VoidCallback onPressed;

//   PermissionItem({
//     required this.permission,
//     required this.status,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text('$permission Permission: $status'),
//       trailing: IconButton(
//         icon: Icon(Icons.settings),
//         onPressed: onPressed,
//       ),
//     );
//   }
// }

// class CameraPage extends StatefulWidget {
//   final bool cameraPermissionAllowed;

//   const CameraPage({Key? key, required this.cameraPermissionAllowed}) : super(key: key);

//   @override
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   late CameraController _controller;
//   late List<CameraDescription> _cameras;
//   bool _isCameraInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     try {
//       if (widget.cameraPermissionAllowed) {
//         _cameras = await availableCameras();
//         _controller = CameraController(_cameras[0], ResolutionPreset.medium);
//         await _controller.initialize();
//         if (mounted) {
//           setState(() {
//             _isCameraInitialized = true;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error initializing camera: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isCameraInitialized) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Camera Page'),
//         ),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Camera Page'),
//       ),
//       body: Center(
//         child: CameraPreview(_controller),
//       ),
//     );
//   }
// }