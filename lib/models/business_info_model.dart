

import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessInfoModel {
  String? userId;
  String? businessName;
  String? email;
  String? ntnNo;
  String? phoneNo;
  String? city;
  String? district;
  String? address;
  String? province;
  String? mandiName;
  String? faxNo;
  String? landlineNo;
  String? secondNo;
  String? thirdNo;
  String? profileImage;
  String? memberSince;
  bool?   membershipStatus;

  BusinessInfoModel({this.userId, this.businessName, this.email, this.ntnNo, this.phoneNo, this.city, this.district, this.address, this.province,
    this.mandiName, this.faxNo, this.landlineNo, this.secondNo, this.thirdNo, this.profileImage, this.memberSince, this.membershipStatus});

  BusinessInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    businessName = json['businessName'];
    email = json['email'];
    ntnNo = json['ntnNo'];
    phoneNo = json['phoneNo'];
    city = json['city'];
    district = json['district'];
    address = json['address'];
    province = json['province'];
    mandiName = json['mandi'];
    faxNo = json['faxNo'];
    landlineNo = json['landlineNo'];
    secondNo = json['secondNo'];
    thirdNo = json['thirdNo'];
    profileImage = json['image'];
    memberSince = json['memberSince'];
    membershipStatus = json['membershipStatus'];
  }

  factory BusinessInfoModel.fromDocument(DocumentSnapshot doc) {
    return BusinessInfoModel(
      userId: doc.get('id'),
      businessName: doc.get('businessName'),
      email: doc.get('email'),
      ntnNo: doc.get('ntnNo'),
      phoneNo: doc.get('phoneNo'),
      city: doc.get('city'),
      district: doc.get('district'),
      address: doc.get('address'),
      province: doc.get('province'),
      mandiName: doc.get('mandi'),
      faxNo: doc.get('faxNo'),
      landlineNo: doc.get('landlineNo'),
      secondNo: doc.get('secondNo'),
      thirdNo: doc.get('thirdNo'),
      profileImage: doc.get('image'),
      memberSince: doc.get('memberSince'),
      membershipStatus: doc.get('membershipStatus'),
    );
  }

}