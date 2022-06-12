


import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String? userId;
  String? name;
  String? email;

  UsersModel({this.userId, this.name, this.email });

  factory UsersModel.fromDocument(DocumentSnapshot doc) {
    return UsersModel(
      userId: doc.get('id'),
      name: doc.get('name'),
      email: doc.get('email'),
    );
  }

  UsersModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    name = json['name'];
    email = json['email'];
  }

}