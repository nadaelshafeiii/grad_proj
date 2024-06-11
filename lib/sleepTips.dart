import 'dart:async';
import 'package:flutter/material.dart';

class sleepTips extends StatefulWidget {
  @override
  _sleepTipsState createState() => _sleepTipsState();
}

class _sleepTipsState extends State<sleepTips> {
  late Timer _timer;
  int _currentIndex = 0;

  final List<String> _sleepTips = [
    "Establish a regular sleep schedule.",
    "Create a relaxing bedtime routine.",
    "Limit exposure to screens before bedtime.",
    "Ensure your sleep environment is comfortable and quiet.",
    "Avoid large meals, caffeine, and alcohol before bedtime.",
    "Stay physically active during the day.",
    "Manage stress and anxiety.",
    "Avoid naps during the day, especially in the late afternoon.",
  ];

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _timer = Timer.periodic(Duration(seconds: 15), (Timer timer) {
      setState(() {
        // Increment the index to display the next sleep tip
        _currentIndex = (_currentIndex + 1) % _sleepTips.length;
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), // Rounded all corners
          color: const Color(0xFF2BA0B6), // Hex color: 1F7F8D
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Color of the shadow
              spreadRadius: 5, // Spread radius
              blurRadius: 7, // Blur radius
              offset: const Offset(0, 3), // Offset of the shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sleep Tips",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              _sleepTips[_currentIndex],
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
