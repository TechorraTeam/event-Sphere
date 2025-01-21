import 'package:event_sphere/View/screens/Add_Event_Form.dart';
import 'package:event_sphere/View/screens/Events_Screen.dart';
import 'package:event_sphere/View/screens/My_Events_Screen.dart';
import 'package:event_sphere/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(

          toolbarHeight: 60.h, 
          iconTheme: IconThemeData(
          color: Colors.black , 
        ),
          actions: [
          Padding(
            padding:  EdgeInsets.only(right:16.h),
            child: CircleAvatar(
              radius: 20, 
              backgroundColor: const Color.fromARGB(255, 234, 160, 47),
              //backgroundImage: 
            ),
          ),
        ],
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h,),
              Padding(
                padding:  EdgeInsets.only(left: 10.w,right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Popular Events"),
                    Text("View All",style: TextStyle(color: const Color.fromARGB(255, 156, 156, 156),fontSize: 11),),
                  ],
                ),
              ),
            ],
          ),
        ),

        drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.orangeAccent,
              child: Padding(
                padding:  EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05, 
                  top: MediaQuery.of(context).size.height * 0.07, 
                  bottom: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Row(
                  children: [
                    CircleAvatar(radius: MediaQuery.of(context).size.width * 0.075,),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text('Mohsin Faraz',style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width * 0.04,color: Colors.white),),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left:10.0,right:10),
                            child: Text('Verified',style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.030,color: Colors.black),),
                          ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  
                  ExpansionTile(
                    leading: const Icon(Icons.send_outlined, color: Colors.black),
                    title: const Text("Event", style: TextStyle(color: Colors.black)),
                    iconColor: Colors.black,
                    collapsedIconColor: Colors.black,
                    children: [
                      Container(
                        color: const Color.fromARGB(255, 244, 241, 241),
                        child: ListTile(
                          title: const Text(
                            "Publish Event",
                            style: TextStyle(color: Colors.black), 
                          ),
                          onTap: () {
                            Get.to(AddEventForm());
                          },
                        ),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 244, 241, 241),
                        child: ListTile(
                          title: const Text(
                            "All Events",
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Get.to(EventsScreen());
                          },
                        ),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 244, 241, 241),
                        child: ListTile(
                          title: const Text(
                            "My Events",
                            style: TextStyle(color: Colors.black), 
                          ),
                          onTap: () {
                            Get.to(MyEventsScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_city_rounded, color: Colors.black),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Location", style: TextStyle(color: Colors.black)),
                        Container(
                          padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02, 
                          vertical: MediaQuery.of(context).size.height * 0.005,  
                        ),
        
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Coming Soon",
                            style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.025, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  
                ],
              ),
            ),
            
            Container(
              color: Colors.orangeAccent,
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  authController.logOut();
                },
              ),
            ),
          ],
        ),
      ),

      );
    });
  }
}
