import 'package:event_sphere/View/screens/Add_Event_Form.dart';
import 'package:event_sphere/View/screens/Event_Detail_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event_sphere/controller/event_controller.dart';
import 'package:event_sphere/model/event_data_model.dart';

class MyEventsScreen extends StatelessWidget {
  final EventController _eventController = Get.find<EventController>();

  MyEventsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Events'),
      ),
      body: FutureBuilder<List<EventDataModel>>(
        future: _eventController.getEventsByUserId(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No events available'));
          } else {
            final events = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(13),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 7,
                ),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => {
                      Get.to(EventDetailScreen(eventId: events[index].id ?? "",))
                    },
                    child: Card(
                      elevation: 7,
                      color: Colors.amber.shade200,
                      child: ListTile(
                        title: Text(
                          events[index].title?.capitalize ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              events[index].description ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_pin, color: Colors.lightGreen),
                                    Text(
                                      events[index].location?.capitalize?.split(' ')[0].replaceAll(',', '') ?? "",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.lightGreen,
                                          fontWeight: FontWeight.w600
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_month_rounded, color: Colors.blueAccent),
                                    SizedBox(width: 2),
                                    Text(formatDateString(events[index].date  ?? ""), style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    )),
                                    SizedBox(width: 4),
                                    Text(events[index].time ?? "", style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

String formatDateString(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return "${_getMonthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}";
}

String _getMonthName(int month) {
  const months = [
    "Jan", "Feb", "Mar", "April", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
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
