import 'package:event_sphere/View/screens/Add_Event_Form.dart';
import 'package:event_sphere/View/screens/Event_Detail_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:event_sphere/controller/event_controller.dart';
import 'package:event_sphere/model/event_data_model.dart';
import 'package:intl/intl.dart';

class DashboardPopularEvents extends StatelessWidget {
  final EventController _eventController = Get.put(EventController());

  DashboardPopularEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventDataModel>>(
      future: _eventController.getAllEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No events available'));
        } else {
          final events = snapshot.data!;
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding:  EdgeInsets.only(left: 30.w,top: 20.h),
            separatorBuilder: (context, index) => SizedBox(width: 25.w),
            itemCount: events.length,
            itemBuilder: (context, index) {
              EventDataModel eventData = events[index];
              return InkWell(
                onTap: () => {
                  Get.to(EventDetailScreen(
                    eventId: events[index].id ?? "",
                  ))
                },
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage('assets/images/china_town.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 225.w,
                    height: 200.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(top: 6.h, left: 185.w),
                    height: 38.h,
                    width: 35.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 4.h),
                          child: Text(
                            DateFormat('MMM')
                                .format(DateTime.parse(eventData.date!)),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                           DateTime.parse(eventData.date!).day.toString(),
                          style: TextStyle(fontSize: 12,color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 175.h, left: 13.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    height: 50.h,
                    width: 200.w,
                    child: Padding(
                      padding:  EdgeInsets.only(top: 7.h,left: 13.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(eventData.title!,style: TextStyle(fontWeight: FontWeight.w600),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.location_on_outlined,color: Colors.grey,),
                              Text(eventData.location!,style: TextStyle(color: Colors.grey),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            },
          );
        }
      },
    );
  }
}

String formatDateString(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return "${_getMonthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}";
}

String _getMonthName(int month) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "April",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  return months[month - 1];
}

String formatTimeString(String timeString) {
  final timeParts = timeString.split(':');
  final hour = int.parse(timeParts[0]);
  final minute = int.parse(timeParts[1]);

  final period = hour >= 12 ? 'pm' : 'am';
  final formattedHour = hour % 12 == 0 ? 12 : hour % 12;

  return '$formattedHour:${minute.toString().padLeft(2, '0')} $period';
}
