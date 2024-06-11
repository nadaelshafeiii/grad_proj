import 'package:flutter/material.dart';
import 'package:gp4/components/MyDraewer.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'About Us Page',
      home: AboutUsPage(),
    );
  }
}
// ignore: must_be_immutable
class AboutUsPage extends StatelessWidget {
  AboutUsPage({super.key});
  Map<String, dynamic>? userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 74, 82),
                title: Center(child: Text('About Our App'.tr, style: TextStyle(color: Colors.white,fontSize: 24, fontWeight: FontWeight.bold),)),

        elevation: 0,
        
      ),         
      drawer:  MyDrawer(),

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
      
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(
          child: Image.asset(
              'assets/images/IMG_0533.png',
                width: 100,
                ),
        ),
            const SizedBox(height: 20,),

            const SizedBox(height: 10),
            Text(
              'Our app, SleepGuard, is a revolutionary solution designed to prevent accidents caused by drowsy driving. We understand the dangers of driving while fatigued, and our mission is to provide drivers with a tool that helps them stay alert and safe on the road.'.tr,
              style: TextStyle(fontSize: 16,color: Colors.white60),
            ),
            const SizedBox(height: 20),
            Text(
              'Our Mission'.tr,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'At SleepGuard, our mission is to save lives by reducing the number of accidents caused by drowsy driving. We aim to achieve this by developing innovative technologies that detect signs of fatigue and provide timely alerts to drivers, allowing them to take necessary precautions and avoid accidents.'.tr,
              style: TextStyle(fontSize: 16,color: Colors.white60),
            ),
            const SizedBox(height: 20),
            Text(
              'Meet Our Team'.tr,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            const SizedBox(height: 10),
            _buildTeamMember(
              name: 'Nada Elshafey',
              role: 'Flutter Developer',
              imageUrl: 'assets/images/flutter-icon-1651x2048-ojswpayr.png',
              color:Colors.white ,

            ),
            const SizedBox(height: 10),
            _buildTeamMember(
              name: 'Nada Nagy',
              role: 'Flutter Developer',
              imageUrl: 'assets/images/flutter-icon-1651x2048-ojswpayr.png',
              color:Colors.white ,

            ),

            const SizedBox(height: 10),
            _buildTeamMember(
              name: 'Roaa Ahmed',
              role: 'Flutter Developer',
              imageUrl: 'assets/images/flutter-icon-1651x2048-ojswpayr.png',
                              color: Colors.white,


            ),
            
            const SizedBox(height: 10),
            _buildTeamMember(
              name: 'Youmna Ramdan',
              role: 'Flutter Developer',
              imageUrl: 'assets/images/flutter-icon-1651x2048-ojswpayr.png', 
              color:Colors.white ,

            ),
            
            const SizedBox(height: 10),
            _buildTeamMember(
              name: 'Dareeen Mohamed',
              role: 'Machine Learning',
              imageUrl: 'assets/images/8345929.png',
              color:Colors.white ,

            ),
            
            const SizedBox(height: 10),
            _buildTeamMember(
              name: 'Abdallah Mohamed',
              role: 'Back End Developer',
              imageUrl: 'assets/images/8099442.png',
              color:Colors.white ,
                          
            ),
            
            
            
            
            // Add more team members as needed
          ],
        ),
      ),
      )  );
  }

  Widget _buildTeamMember({
    required String name,
    required String role,
    required String imageUrl, required Color color, 
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imageUrl),
      ),
      title: Text(name),
      subtitle: Text(role),
    );
  }
}
