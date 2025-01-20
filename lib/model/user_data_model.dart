import 'package:flutter/material.dart';

class UserDataModel {
  UserDataModel(
      {this.id = '',
      this.name = '',
      this.type ='individual',
      this.email,
      this.profilePicture,
      // created date
      // gender
      });

  String? id;
  String? name;
  String? type;
  String? email;
  Image? profilePicture;
}