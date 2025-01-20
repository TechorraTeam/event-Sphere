import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UserDataModel {
  UserDataModel(
      {this.id = '',
      this.name = '',
      this.type ='individual',
      this.email,
      this.profilePicture,
      this.gender
      }): creationDate = DateTime.now();

  String? id;
  String? name;
  String? type;
  String? email;
  String? gender;
  final DateTime creationDate ;
  String? profilePicture;
  factory UserDataModel.fromDocumentSnapshot(DocumentSnapshot doc) =>
      UserDataModel(
          id: doc["uid"],
          name: doc["name"],
          type: doc["type"],
          email: doc["email"],
          gender: doc["gender"],
          profilePicture: doc["profilePicture"],
          );

  Map<String, dynamic> toMap() => {
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "name": name,
        "type": type,
        "email": email,
        "gender": gender,
        "profilePicture": profilePicture,
        "creationDate": creationDate,
      };
}