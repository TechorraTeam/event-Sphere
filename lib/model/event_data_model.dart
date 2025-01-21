import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDataModel {
  EventDataModel({
    this.id = '',
    this.uid='',
    this.title = '',
    this.description='individual',
    this.location,
    this.date,
    this.time,
    this.ticketPrice,
    this.images,
    this.isFamilyOriented
  });

  String? id;
  String? uid;
  String? title;
  String? description;
  String? location;
  String? date;
  String? time;
  String? ticketPrice;
  List<String>? images;
  bool? isFamilyOriented;

  factory EventDataModel.fromDocumentSnapshot(DocumentSnapshot doc) =>
      EventDataModel(
          id: doc["eid"],
          uid: doc["uid"],
          title: doc["title"],
          description: doc["description"],
          location: doc["location"],
          date: doc["date"],
          time: doc["time"],
          ticketPrice: doc["ticketPrice"],
          isFamilyOriented: doc["isFamilyOriented"]
      );

  Map<String, dynamic> toMap() => {
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "title": title,
        "description": description,
        "location": location,
        "date": date,
        "time": time,
      };
}