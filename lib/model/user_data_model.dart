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
  Image? profilePicture;
  factory UserDataModel.fromDocumentSnapshot(DocumentSnapshot doc) =>
      UserDataModel(
          id: doc["id"],
          name: doc["name"],
          type: doc["type"],
          email: doc["email"],
          gender: doc["gender"],
          profilePicture: doc["profilePicture"],
          );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "email": email,
        "gender": gender,
        "profilePicture": profilePicture,
        "creationDate": creationDate,
        
      };
}