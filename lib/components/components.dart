// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NavigatorBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  NavigatorBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(0xFF, 0x14, 0x32, 0x3E),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30, color: Colors.white),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_outlined, size: 30, color: Colors.white),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assessment_outlined, size: 30, color: Colors.white),
              label: '',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.blue,
          onTap: onTap,
        ),
      ),
    );
  }
}
