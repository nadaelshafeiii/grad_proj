import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'LoginPage.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;
  const CameraPage({Key? key, required this.camera, required bool cameraPermissionAllowed}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  final FlutterTts _flutterTts = FlutterTts();
  int detectionCounter = 0;
  final int detectionThreshold = 5;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.veryHigh,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _initializeControllerFuture = _controller.initialize();
    _startImageCaptureTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startImageCaptureTimer() {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_controller.value.isInitialized) {
        _takePictureAndProcess();
      }
    });
  }

  Future<void> _takePictureAndProcess() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      final apiUrl = Uri.parse("http://45.242.245.146:4000/sleepdetection/");
      final bytes = await image.readAsBytes();
      final imageBytes = Uint8List.fromList(bytes);
      var request = MultipartRequest('POST', apiUrl);
      request.files.add(MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'image.jpg',
      ));
      var response = await request.send();
      if (response.statusCode == 201) {
        final responseJson = await response.stream.bytesToString();
        _speakText("Wake up");
      _incrementDetectionCounter();

        print('Detected faces: $responseJson');
      } else {
        print('Failed to detect faces. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  Future<void> _speakText(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(1.0);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(6.0);
    await _flutterTts.speak(text); 
  }

void _incrementDetectionCounter() {
  setState(() {
    detectionCounter++;
    if (detectionCounter >= detectionThreshold) {
      sendemail();
      print('send email');
      detectionCounter = 0; // Reset the counter after sending the email
    }
  });
}

Map<String, dynamic>? data;

Future<void> sendemail() async {
String? token = await AuthService.getToken();


    var requestBody = {
      "message": "help",
            "latitude": '',
      "longitude": '',
    };
var response = await http.post(
  Uri.parse('http://45.242.245.146:8000/sendemail/'),
  headers: {
    'Authorization': 'Token $token',
    'Content-Type': 'application/json',

  },
  body: jsonEncode(requestBody),

);
if (response.statusCode == 200) {
  setState(() {
    print('token');
  });
} else {
  print('Failed to fetch user data');
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePictureAndProcess,
        child: Icon(Icons.camera),
      ),
      body: Column(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                 
                });
                return CameraPreview(_controller);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
