import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gp4/utils.dart' as date_util;
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:gp4/sleepTips.dart';
import 'package:http/http.dart';

import 'functions.dart/auth_service.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var shour = 0;
  var whour = 0;
  var sminute = 0;
  var wminute = 0;
  var stimeFormat = "AM";
  var wtimeFormat = "AM";
  var totalSleepHours = 0; 
  int displayedPercentage = 0;
  String sleepHour = '';
  String wokeUpHour = '';
  String formattedDate ='';

  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  TextEditingController controller = TextEditingController();
  late double initialOffset;  

  @override
  void initState() {
    super.initState();
    setup();
    SleepData();
  }

  void setup() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
  }

  Widget hrizontalCapsuleListView() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentDateTime = currentMonthList[index];
            SleepData();
          });
        },
        child: Container(
          width: 71,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: (currentMonthList[index].day != currentDateTime.day)
                  ? [
                      Colors.white.withOpacity(0.8),
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.6)
                    ]
                  : [
                      Colors.black,
                      const Color.fromARGB(0xFF, 0x14, 0x32, 0x3E),
                      const Color.fromARGB(0xFF, 0x1F, 0x7F, 0x8D)
                    ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: const [0.0, 0.5, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  currentMonthList[index].day.toString(),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: (currentMonthList[index].day != currentDateTime.day)
                        ? Colors.white
                        : Colors.white,
                  ),
                ),
                Text(
                  date_util.DateUtils
                      .weekdays[currentMonthList[index].weekday - 1],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: (currentMonthList[index].day != currentDateTime.day)
                        ? Colors.white
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topView() {
    return Container(
      height: height * 0.3,
      width: width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.only(top: 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          hrizontalCapsuleListView(),
        ],
      ),
    );
  }

 bool isSleepPickerVisible = false;
 bool isWakeupPickerVisible = false;

 Widget sleepPicker() {
   double width = MediaQuery.of(context).size.width;
   double height = MediaQuery.of(context).size.height;

   double containerWidth = width * 0.9;
   int totalHours = 0;
   int totalMinutes = 0;

   wokeUpHour = "${whour.toString().padLeft(2, '0')}:${wminute.toString().padLeft(2, "0")} $wtimeFormat";
   sleepHour = "${shour.toString().padLeft(2, '0')}:${sminute.toString().padLeft(2, "0")} $stimeFormat";

   String calculateTotalSleepHours(var wokeUpTime, var sleepTime) {
   // Split wake up time and sleep time to extract hours and minutes
   List<String> wokeUpParts = wokeUpTime.split(' ');
   List<String> wokeUpHoursMinutes = wokeUpParts[0].split(':');
   int wokeUpHour = int.parse(wokeUpHoursMinutes[0]);
   int wokeUpMinute = int.parse(wokeUpHoursMinutes[1]);

   // Convert wake up time to 24-hour format
   if (wokeUpParts[1] == 'PM' && wokeUpHour != 12) {
     wokeUpHour += 12;
   }

   List<String> sleepParts = sleepTime.split(' ');
   List<String> sleepHoursMinutes = sleepParts[0].split(':');
   int sleepHour = int.parse(sleepHoursMinutes[0]);
   int sleepMinute = int.parse(sleepHoursMinutes[1]);

   // Convert sleep time to 24-hour format
   if (sleepParts[1] == 'PM' && sleepHour != 12) {
     sleepHour += 12;
   }
 
   // Calculate total sleep hours
    totalHours = wokeUpHour - sleepHour;
    totalMinutes = wokeUpMinute - sleepMinute;

   // Adjust total hours and minutes if necessary
   if (totalHours < 0 || (totalHours == 0 && totalMinutes < 0)) {
     totalHours += 24;
   }
 
   if (totalMinutes < 0) {
     totalHours--;
     totalMinutes += 60;
   }

   return '$totalHours : $totalMinutes';
  }

  var totalSleepHours = calculateTotalSleepHours(wokeUpHour, sleepHour);
  

  int calculateSleepQuality(minutesSlept) {
  int minutesSlept = totalHours * 60 + totalMinutes;

  // Total hours in a day
  int totalHoursInDay = 1440;

  // Calculate the percentage of sleep compared to total hours
  int sleepPercentage = ((minutesSlept / totalHoursInDay) * 100).toInt();

  // Ensure sleepPercentage does not exceed 100
  if (sleepPercentage > 100) {
    sleepPercentage = 100;
  }

  return sleepPercentage;
 }

 
   return Center(
     child: Column(
       children: [
         const SizedBox(height: 20), // Add space above the container
         SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: Container(
             height: height * 0.2,
             width: containerWidth,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(40), // Rounded all corners
               color: const Color(0xFF1F7F8D), // Hex color: 1F7F8D
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.1), // Color of the shadow
                   spreadRadius: 5, // Spread radius
                   blurRadius: 7, // Blur radius
                   offset: const Offset(0, 3), // Offset of the shadow
                 ),
               ],
             ),
             child: Row(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 8.0),
                   child: ElevatedButton(
                     onPressed: () {
                       setState(() {
                         isSleepPickerVisible = !isSleepPickerVisible;
                         isWakeupPickerVisible = false;
                       });
                     },
                     style: ElevatedButton.styleFrom(
                       shadowColor: Colors.black, // Remove shadow color
                       padding: EdgeInsets.zero,
                       shape: const CircleBorder(), // Circle shape
                       backgroundColor: const Color(0xFF2BA0B6), // Button background color
                     ),
                     child: const Padding(
                       padding: EdgeInsets.all(8.0), // Adjust padding for size
                       child: Icon(
                         Icons.calendar_today,
                         color: Colors.white,
                         size: 20,
                       ),
                     ),
                   ),
                 ),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start of the column
                       children: [
                         const Text(
                           "Slept at:",
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 16, // Decreased font size
                             color: Colors.white,
                           ),
                         ),
                         const SizedBox(height: 8), // Add some space between the two texts
                         Text(
                           sleepHour,
                           style: const TextStyle(
                             fontSize: 14,
                             color: Colors.white,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 8.0), // Add padding here
                   child: ElevatedButton(
                     onPressed: () {
                       setState(() {
                         isWakeupPickerVisible = !isWakeupPickerVisible;
                         isSleepPickerVisible = false;
                       });
                     },
                     style: ElevatedButton.styleFrom(
                       shadowColor: Colors.black, // Remove shadow color
                       padding: EdgeInsets.zero,
                       shape: const CircleBorder(), // Circle shape
                       backgroundColor: const Color(0xFF2BA0B6), // Button background color
                     ),
                     child: const Padding(
                       padding: EdgeInsets.all(8.0), // Adjust padding for size
                       child: Icon(
                         Icons.calendar_today,
                         color: Colors.white,
                         size: 20,
                       ),
                     ),
                   ),
                 ),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start of the column
                       children: [
                         const Text(
                           "Woke up at:",
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 16, // Decreased font size
                             color: Colors.white,
                           ),
                         ),
                         const SizedBox(height: 8), // Add some space between the two texts
                         Text(
                           wokeUpHour,
                           style: const TextStyle(
                             fontSize: 14,
                             color: Colors.white,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start of the column
                       children: [
                         const SizedBox(height: 8), // Add some space between the two texts
                         const Text(
                           "Total Sleep Hours: ",
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 16,
                             color: Colors.white,
                           ),
                         ),
                         const SizedBox(height: 8),
                         Text(
                           totalSleepHours,
                           style: const TextStyle(
                             fontSize: 14,
                             color: Colors.white,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ],
             ),
           ),
         ),
         if (isSleepPickerVisible)
           Container(
             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
             decoration: BoxDecoration(
               color: Colors.black87,
               borderRadius: BorderRadius.circular(10),
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 NumberPicker(
                   minValue: 0,
                   maxValue: 11,
                   value: shour,
                   zeroPad: true,
                   infiniteLoop: true,
                   itemWidth: 80,
                   itemHeight: 60,
                   onChanged: (value) {
                     setState(() {
                       shour = value;
                     });
                   },
                   textStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                   selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
                   decoration: const BoxDecoration(
                     border: Border(
                       top: BorderSide(
                         color: Colors.white,
                       ),
                       bottom: BorderSide(color: Colors.white),
                     ),
                   ),
                 ),
                 NumberPicker(
                   minValue: 0,
                   maxValue: 59,
                   value: sminute,
                   zeroPad: true,
                   infiniteLoop: true,
                   itemWidth: 80,
                   itemHeight: 60,
                   onChanged: (value) {
                     setState(() {
                       sminute = value;
                     });
                   },
                   textStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                   selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
                   decoration: const BoxDecoration(
                     border: Border(
                       top: BorderSide(
                         color: Colors.white,
                       ),
                       bottom: BorderSide(color: Colors.white),
                     ),
                   ),
                 ),
                 Column(
                   children: [
                     GestureDetector(
                       onTap: () {
                         setState(() {
                           stimeFormat = "AM";
                         });
                       },
                       child: Container(
                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                         decoration: BoxDecoration(
                           color: stimeFormat == "AM" ? Colors.grey.shade800 : Colors.grey.shade700,
                           border: Border.all(
                             color: stimeFormat == "AM" ? Colors.grey : Colors.grey.shade700,
                           ),
                         ),
                         child: const Text(
                           "AM",
                           style: TextStyle(color: Colors.white, fontSize: 18), // Smaller text size
                         ),
                       ),
                     ),
                     const SizedBox(
                       height: 10,
                     ),
                     GestureDetector(
                       onTap: () {
                         setState(() {
                           stimeFormat = "PM";
                         });
                       },
                       child: Container(
                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                         decoration: BoxDecoration(
                           color: stimeFormat == "PM" ? Colors.grey.shade800 : Colors.grey.shade700,
                           border: Border.all(
                             color: stimeFormat == "PM" ? Colors.grey : Colors.grey.shade700,
                           ),
                         ),
                         child: const Text(
                           "PM",
                           style: TextStyle(color: Colors.white, fontSize: 18), // Smaller text size
                         ),
                       ),
                     ),
                   ],
                 )
               ],
             ),
           ),
         
         if (isWakeupPickerVisible)
         Container(
             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
             decoration: BoxDecoration(
               color: Colors.black87,
               borderRadius: BorderRadius.circular(10),
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 NumberPicker(
                   minValue: 0,
                   maxValue: 11,
                   value: whour,
                   zeroPad: true,
                   infiniteLoop: true,
                   itemWidth: 80,
                   itemHeight: 60,
                   onChanged: (value) {
                     setState(() {
                       whour = value;
                     });
                   },
                   textStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                   selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
                   decoration: const BoxDecoration(
                     border: Border(
                       top: BorderSide(
                         color: Colors.white,
                       ),
                       bottom: BorderSide(color: Colors.white),
                     ),
                   ),
                 ),
                 NumberPicker(
                  minValue: 0,
                   maxValue: 59,
                   value: wminute,
                   zeroPad: true,
                   infiniteLoop: true,
                   itemWidth: 80,
                   itemHeight: 60,
                   onChanged: (value) {
                     setState(() {
                       wminute = value;
                     });
                   },
                   textStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                   selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
                   decoration: const BoxDecoration(
                     border: Border(
                       top: BorderSide(
                         color: Colors.white,
                       ),
                        bottom: BorderSide(color: Colors.white),
                     ),
                   ),
                 ),
                 Column(
                   children: [
                     GestureDetector(
                       onTap: () {
                         setState(() {
                           wtimeFormat = "AM";
                         });
                       },
                       child: Container(
                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                         decoration: BoxDecoration(
                           color: wtimeFormat == "AM" ? Colors.grey.shade800 : Colors.grey.shade700,
                           border: Border.all(
                             color: wtimeFormat == "AM" ? Colors.grey : Colors.grey.shade700,
                           ),
                         ),
                         child: const Text(
                           "AM",
                           style: TextStyle(color: Colors.white, fontSize: 18), // Smaller text size
                         ),
                       ),
                     ),
                     const SizedBox(
                       height: 10,
                     ),
                     GestureDetector(
                       onTap: () {
                         setState(() {
                           wtimeFormat = "PM";
                         });
                       },
                       child: Container(
                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                         decoration: BoxDecoration(
                           color: wtimeFormat == "PM" ? Colors.grey.shade800 : Colors.grey.shade700,
                           border: Border.all(
                             color: wtimeFormat == "PM" ? Colors.grey : Colors.grey.shade700,
                           ),
                         ),
                         child: const Text(
                           "PM",
                           style: TextStyle(color: Colors.white, fontSize: 18), // Smaller text size
                         ),
                       ),
                     )
                   ],
                 )
               ],
             ),
           ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // setState(() {
              //   displayedPercentage = calculateSleepQuality(totalSleepHours);
              // });
              String formatted_date = date_util.DateUtils.months[currentDateTime.month - 1] + ' ' + currentDateTime.day.toString();
              var exist_data = {"sleep_date": formatted_date};
              String? token = await AuthService.getToken();
              var exist_response = await post(
              Uri.parse("http://45.242.245.146:8000/checksleepdata/"),
              headers: {"Content-Type": "application/json", "Authorization": "Token $token"},
              body: jsonEncode(exist_data),
              );
               if (exist_response.statusCode == 201){
               print("exists");
               }
               else{
               print("do not exist");
               var add_data = {"sleep_date": formatted_date, "sleep_time": sleepHour, 'wakeup_time': wokeUpHour, 'sleep_hour': shour, 'sleep_minute': sminute, 'sleep_format': stimeFormat, 'wakeup_hour': whour, 'wakeup_minute': wminute, 'wakeup_format': wtimeFormat};
               var add_response = await post(
                 Uri.parse("http://45.242.245.146:8000/addsleepdata/"),
                 headers: {"Content-Type": "application/json", "Authorization": "Token $token"},
                 body: jsonEncode(add_data),
               );
               if (add_response.statusCode == 201){
                 print("data added successfully");
               }
               else{
                var sleep_data_errors = jsonDecode(add_response.body);
                print(sleep_data_errors);
               }
            }},
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.black, // Remove shadow color
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal padding for size
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0), // Rounded edges for the button
              ),
              backgroundColor: const Color(0xFF2BA0B6), // Button background color
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.assessment,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8.0), // Space between the icon and the text
                Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(right: 200),
            child: Text(
              "Sleep Quality:",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        const SizedBox(height: 10), // Add space between text and CircularPercentIndicator
        CircularPercentIndicator(
          animation: true,
          animationDuration: 1000,
          radius: 130,
          lineWidth: 30,
          percent:  displayedPercentage / 100, 
          progressColor: const Color.fromARGB(255, 20, 99, 111),
          backgroundColor: const Color.fromARGB(0xFF, 0x1F, 0x7F, 0x8D),
          circularStrokeCap: CircularStrokeCap.round,
          center: Text(
            '$displayedPercentage%', 
            style: const TextStyle(
              fontSize: 50,
              color: Colors.white,
            ),
          ),
        ),
       ],
     ),
   );
  }


  @override
  Widget build(BuildContext context) {
   width = MediaQuery.of(context).size.width;
   height = MediaQuery.of(context).size.height;
   int selectedIndex = currentMonthList.indexWhere((date) => date.day == currentDateTime.day);
   initialOffset = selectedIndex * 80.0 - (MediaQuery.of(context).size.width / 2 - 40) + 40 - (80 / 2); // Adjusted initial offset
   scrollController = ScrollController(initialScrollOffset: initialOffset);
   String formattedDate = date_util.DateUtils.months[currentDateTime.month - 1] + ' ' + currentDateTime.day.toString();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(0xFF, 0x1F, 0x7F, 0x8D),
            Color.fromARGB(0xFF, 0x14, 0x32, 0x3E),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                formattedDate,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(0xFF, 0x1F, 0x7F, 0x8D),
                  Color.fromARGB(0xFF, 0x14, 0x32, 0x3E),
                ],
              ),
            ),
            child: ListView(
              children: [
                const DrawerHeader(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 80,
                        color: Colors.white,
                      ),
                      Text(
                        'username',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end, 
            children: [
              topView(),
              sleepPicker(),
              const SizedBox(height: 25),         
              sleepTips(),
            ],
          ),
        ),
       //bottomNavigationBar: NavigatorBar(),
      ),
    );
  }
  Future<void> SleepData() async {
    String formatted_date_api = date_util.DateUtils.months[currentDateTime.month - 1] + ' ' + currentDateTime.day.toString();
    var data = {"sleep_date": formatted_date_api};
    String? token = await AuthService.getToken();
    var response = await post(
      Uri.parse("http://45.242.245.146:8000/getsleepdata/"),
      headers: {"Content-Type": "application/json", "Authorization": "Token $token"},
      body: jsonEncode(data),
    );
    if (response.statusCode == 201){
      print("found");
      var response_json = jsonDecode(response.body);
      setState(() {
        formattedDate = response_json['sleep_date'];
        sleepHour = response_json['sleep_time'];
        wokeUpHour = response_json['wakeup_time'];
        shour = response_json['sleep_hour'];
        sminute = response_json['sleep_minute'];
        stimeFormat = response_json['sleep_format'];
        whour = response_json['wakeup_hour'];
        wminute = response_json['wakeup_minute'];
        wtimeFormat = response_json['wakeup_format'];
        displayedPercentage = response_json['sleep_percentage'];
      });
    }
    else{
      print("not found");
      formattedDate = '';
      sleepHour = '';
      wokeUpHour = '';
      shour = 0;
      sminute = 0;
      stimeFormat = 'AM';
      whour = 0;
      wminute = 0;
      wtimeFormat = 'AM';
      displayedPercentage = 0;
    }
  }
}