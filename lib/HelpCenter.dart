// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gp4/components/MyDraewer.dart';
import 'package:get/get.dart';

class HelpCenterPage extends StatefulWidget {
  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 74, 82),
        elevation: 0,
        title: Center(
          child: Text(
            'Help Center'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),
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
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Image.asset(
              'assets/images/IMG_0533.png',
              width: 150,
              height: 150,
            ),
            SectionTitle(title: 'Overview'.tr),
            SectionContent(
              content: 'Welcome to our Sleeping Drive Detection app help center. Our app helps detect drowsiness while driving to prevent accidents and promote road safety.'.tr
            ),
            SectionTitle(title: 'Features'.tr),
            SectionContent(
              content: '• Real-time monitoring of driver\'s eyelid movements.\n'
                  '• Audio and visual alerts when drowsiness is detected.\n'
                  '• Customizable settings for sensitivity and alert preferences.'.tr,
            ),
            SectionTitle(title: 'How to Use'.tr),
            SectionContent(
              content: '1. Open the app and place your device securely in the car.\n'
                  '2. Start driving.\n'
                  '3. Pay attention to audio and visual alerts if drowsiness is detected.'.tr,
            ),
            SectionTitle(title: 'Troubleshooting'.tr),
            SectionContent(
              content: '• If alerts are not working, ensure that your device '
                  'is positioned correctly and has a clear view of your face.\n'
                  '• Check that the app has permission to access your device\'s camera and microphone.'.tr,
            ),
            SectionTitle(title: 'Safety Tips'.tr),
            SectionContent(
              content: '• Get enough rest before driving, and take regular breaks on long trips.\n'
                  '• Avoid driving if you feel tired or drowsy.\n'
                  '• Listen to your body and recognize warning signs of fatigue.'.tr,
            ),
            SectionTitle(title: 'FAQs'.tr),
            SectionContent(
              content: 'Q: How accurate is the drowsiness detection?\nA: The accuracy of detection may vary based on individual factors and driving conditions.\n'.tr,
            ),
            SectionTitle(title: 'Feedback and Support'.tr),
            SectionContent(
              content: 'We value your feedback! If you have any questions, suggestions, or issues \n regarding the app, please feel free to contact us at srivesupport@example.com.'.tr,
            ),
            SectionTitle(title: 'Terms of Service'.tr),
            SectionContent(
              content: 'Read our Terms of Service for information about the use of our app and your rights and responsibilities.'.tr,
            ),
            SectionTitle(title: 'About'.tr),
            SectionContent(
              content: 'Sleeping Drive Detection v1.0.0\n'
                  'Developed by Srive\n'
                  'Copyright © 2024'.tr,
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SectionContent extends StatelessWidget {
  final String content;

  SectionContent({required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

