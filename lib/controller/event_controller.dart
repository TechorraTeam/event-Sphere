import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sphere/model/event_data_model.dart';
import 'package:event_sphere/model/user_data_model.dart';
import 'package:event_sphere/view/screens/dashboard.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventController extends GetxController {
  Future<void> addEvent(EventDataModel event) async{
    try {
      await FirebaseFirestore.instance.collection('events').add({
        'uid': event.uid,
        'title': event.title,
        'description': event.description,
        'location': event.location,
        'date': event.date,
        'time': event.time,
        'images': event.images,
        'ticketPrice': event.ticketPrice,
        'isFamilyOriented': event.isFamilyOriented,
        'createdAt': Timestamp.now(),
      });
      Get.snackbar("Success", "Event Added Successfully");
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }
  Future<List<EventDataModel>> getAllEvents() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('events').get();
      print("Here");
      List<EventDataModel> events = querySnapshot.docs.map((doc) {
        return EventDataModel(
          uid: doc['uid'],
          title: doc['title'],
          description: doc['description'],
          location: doc['location'],
          date: doc['date'],
          time: doc['time'],
          id: doc.id
        );
      }).toList();
      print(events.length);

      return events;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch events: $e");
      return [];
    }
  }
  Future<EventDataModel?> getEventById(String eventId) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('events').doc(eventId).get();

      if (docSnapshot.exists) {
        EventDataModel event = EventDataModel(
          uid: docSnapshot['uid'],
          title: docSnapshot['title'],
          description: docSnapshot['description'],
          location: docSnapshot['location'],
          date: docSnapshot['date'],
          time: docSnapshot['time'],
          images: List<String>.from(docSnapshot['images'] ?? []),
          ticketPrice: docSnapshot['ticketPrice'],
          isFamilyOriented: docSnapshot['isFamilyOriented'],
          id: docSnapshot.id,
        );
        return event;
      } else {
        Get.snackbar("Error", "Event not found");
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch event: $e");
      return null;
    }
  }

  Future<void> addEventToUser(String eventId) async{
    try {

      await FirebaseFirestore.instance.collection('user_events').add({
        'uid': FirebaseAuth.instance.currentUser?.uid,
        'eid': eventId,
        'createdAt': Timestamp.now(),
      });
      Get.snackbar("Success", "You are Attending the Event");
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  Future<bool> isUserAttendingEvent(String eventId) async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        throw Exception("User not logged in");
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user_events')
          .where('uid', isEqualTo: userId)
          .where('eid', isEqualTo: eventId)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      Get.snackbar("Error", "Failed to check attendance: $e");
      return false;
    }
  }

  Future<List<EventDataModel>> getEventsByUserId(String userId) async {
    try {
      QuerySnapshot userEventsSnapshot = await FirebaseFirestore.instance
          .collection('user_events')
          .where('uid', isEqualTo: userId)
          .get();

      List<String> eventIds = userEventsSnapshot.docs
          .map((doc) => doc['eid'] as String)
          .toList();

      if (eventIds.isEmpty) {
        return [];
      }

      QuerySnapshot eventsSnapshot = await FirebaseFirestore.instance
          .collection('events')
          .where(FieldPath.documentId, whereIn: eventIds)
          .get();

      List<EventDataModel> events = eventsSnapshot.docs.map((doc) {
        return EventDataModel(
          uid: doc['uid'],
          title: doc['title'],
          description: doc['description'],
          location: doc['location'],
          date: doc['date'],
          time: doc['time'],
          id: doc.id,
        );
      }).toList();

      return events;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch events: $e");
      return [];
    }
  }

}
