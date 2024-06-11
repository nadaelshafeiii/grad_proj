import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obsecureText;
  final IconData icon;

  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obsecureText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 40), // Add left padding of 16 pixels
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: TextField(
            controller: controller,
            obscureText: obsecureText,
            decoration: InputDecoration(
              prefixIcon: Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 295), // Move the icon 4 pixels to the right
                    child: Container(
                      width: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(icon, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(22, 139, 159, 0.867), width: 7),
                borderRadius: BorderRadius.circular(30), // Set border radius
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(22, 139, 159, 0.867), width: 7),
                borderRadius: BorderRadius.circular(30), // Set border radius
              ),
              fillColor: Colors.transparent,
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[500]),
            ),
          ),
        ),
      ],
    );
  }
}