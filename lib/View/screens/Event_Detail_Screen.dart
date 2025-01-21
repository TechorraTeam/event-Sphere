import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Widgets/ReadMoreText.dart';
import 'package:event_sphere/controller/event_controller.dart';
import 'package:event_sphere/model/event_data_model.dart';

class EventDetailScreen extends StatelessWidget {
  final String eventId;
  EventDataModel? event;
  EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final EventController _eventController = Get.find<EventController>();

    return FutureBuilder<EventDataModel?>(
      future: _eventController.getEventById(eventId),  // Fetch event by ID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator())
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text('Event not found')),
          );
        } else {
          event = snapshot.data!;

          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: InkWell(
                              onTap: ()=>{Get.back()},
                              child: Icon(Icons.arrow_back_ios_outlined),
                            ),
                          ),
                          Text("Details", style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),),
                          Container(
                            padding: EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Icon(Icons.menu_outlined),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60,),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Image.asset('assets/images/china_town.png'),
                          ),
                        ),
                        Positioned(
                            right: 20,
                            top: 20,
                            child: Card(
                              elevation: 7,
                              child: Container(
                                padding: EdgeInsets.only(left: 15, right: 15, top: 13, bottom: 13),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Column(
                                  children: [
                                    Text(getMonthFromDate(event?.date ?? ""), style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueGrey
                                    )),
                                    SizedBox(height: 3,),
                                    Text(getDayFromDate(event?.date ?? "").toString(), style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepOrange
                                    ))
                                  ],
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event?.title ?? "No title", style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600
                            )),
                            SizedBox(height: 7,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on, color: Colors.blueGrey),
                                SizedBox(width: 7,),
                                Text(event?.location ?? "No location", style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w600
                                ),)
                              ],
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange.shade50,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text("\$${event?.ticketPrice ?? 0}", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepOrange
                          ),),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text("Description", style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600
                    ),textAlign: TextAlign.start,),
                    ReadMoreText(
                      text: event?.description ?? "No description available",
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Material(
              elevation: 700,
              child: Container(
                padding: EdgeInsets.all(20),
                height: 100,
                child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Price", style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600
                            ),),
                            RichText(text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "\$${event?.ticketPrice ?? 0}",
                                      style:TextStyle(
                                          fontSize: 22,
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.w600
                                      )
                                  ),
                                  TextSpan(
                                      text: " /Person",
                                      style:TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600
                                      )
                                  ),
                                ]
                            )),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: ()=>{},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange, // Background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Radius of the button
                              ),
                            ),
                            child: Text("Get A Ticket", style: TextStyle(
                                color: Colors.white
                            ),)
                        )
                      ],
                    )
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

String getMonthFromDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('MMM').format(dateTime); // "Jan"
}

int getDayFromDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  return dateTime.day;
}