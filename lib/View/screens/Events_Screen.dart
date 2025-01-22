import 'package:avatar_stack/animated_avatar_stack.dart';
import 'package:event_sphere/View/screens/Add_Event_Form.dart';
import 'package:event_sphere/View/screens/Event_Detail_Screen.dart';
import 'package:event_sphere/Widgets/EventCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event_sphere/controller/event_controller.dart';
import 'package:event_sphere/model/event_data_model.dart';

class EventsScreen extends StatelessWidget {
  //final EventController _eventController = Get.find<EventController>();
final EventController _eventController = Get.put(EventController());
  EventsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Events'),
      ),
      body: FutureBuilder<List<EventDataModel>>(
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
            return Padding(
              padding: EdgeInsets.all(13),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 7,
                ),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return EventCard(eventDataModel: events[index]);
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Get.to(AddEventForm());
        },
        child: Icon(Icons.add, weight: 30,),
        tooltip: 'Add Event',
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
