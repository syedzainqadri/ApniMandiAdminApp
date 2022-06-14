

import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? cnicNo;
  String? city;
  String? address;
  String? province;
  String? mcln;
  String? approved;
  String? profileImage;

  UserProfileModel({this.userId, this.firstName, this.lastName, this.email, this.phoneNo, this.cnicNo, this.city,
    this.address, this.province, this.mcln, this.approved, this.profileImage});

  factory UserProfileModel.fromDocument(DocumentSnapshot doc) {
    return UserProfileModel(
      userId: doc.get('id'),
      firstName: doc.get('firstName'),
      lastName: doc.get('lastName'),
      email: doc.get('email'),
      phoneNo: doc.get('phoneNo'),
      cnicNo: doc.get('cnicNo'),
      city: doc.get('city'),
      address: doc.get('address'),
      province: doc.get('province'),
      mcln: doc.get('mclNo'),
      approved: doc.get('approved'),
      profileImage: doc.get('image'),
    );
  }

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    cnicNo = json['cnicNo'];
    city = json['city'];
    address = json['address'];
    province = json['province'];
    mcln = json['mclNo'];
    approved = json['approved'];
    profileImage = json['image'];
  }

}