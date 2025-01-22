import 'package:avatar_stack/animated_avatar_stack.dart';
import 'package:event_sphere/model/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/screens/Event_Detail_Screen.dart';

class EventCard extends StatelessWidget {
  final EventDataModel eventDataModel;
  const EventCard({super.key, required this.eventDataModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Get.to(EventDetailScreen(eventId: eventDataModel.id ?? "",))
      },
      child: Card(
        elevation: 7,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 115,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    'assets/images/china_town.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20,),
              SizedBox(
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(eventDataModel.title ?? "", style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_pin, color: Colors.blueGrey),
                        Text(
                          eventDataModel.location?.capitalize?.split(' ')[0].replaceAll(',', '') ?? "",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              child: AnimatedAvatarStack(
                                height: 35,
                                avatars: [
                                  for (var n = 0; n < 3; n++) NetworkImage('https://i.pravatar.cc/150?img=$n'),
                                ],
                              ),
                            ),
                            SizedBox(width: 2,),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.03
                                ),
                                children: [
                                  TextSpan(
                                    text: " 250+",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " Joined",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepOrange
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, right: 7, left: 7),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange.shade100,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: RichText(text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Jan",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.black
                                )
                            ),
                            TextSpan(
                                text: "\n 03",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.deepOrange
                                )
                            )
                          ]
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
