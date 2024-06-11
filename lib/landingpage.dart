import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gp4/signuppage.dart';

import 'local/localecontroller.dart';

// ignore: camel_case_types
class landingpage extends StatelessWidget {
  const landingpage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MyLocaleController controllerLang = Get.find();

    return Scaffold(
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
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Row(
                children: [                
                  MaterialButton(onPressed: () {
                    controllerLang.changeLang("ar");
                  },
                  child: Text("العربية".tr,
                  style: const TextStyle(color: Colors.white,    
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 3.0, 
                  ),
                  ),),

                  MaterialButton(onPressed: () {
                controllerLang.changeLang("en");
              },
              child: Text("English".tr,
              style: const TextStyle(color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 3.0, ),
              ),),
                ],
              ),

                const SizedBox(
                height: 80,
              ),
              Image.asset(
                'assets/images/IMG_0533.png',
                width: 250,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Eyes On The Road'.tr,
                style: GoogleFonts.tajawal(
                  color: const Color(0xFFF1EEEE),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Mind Awake'.tr,
                style: GoogleFonts.tajawal(
                  color: const Color(0xFFF1EEEE),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()));
                },
                // Handle the tap action
        
                child: Container(
                  height: 70,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 22, 139, 159),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      // Add your box shadow properties here
                    ],
                  ),
                  child:  Center(
                    child: Text(
                      'Get Started'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
