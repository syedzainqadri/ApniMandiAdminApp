import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  String? userId;
  String? phoneNo;
  String? transID;
  String? approved;
  String? userName;

  PaymentModel(
      {this.userId, this.phoneNo, this.transID, this.approved, this.userName});

  factory PaymentModel.fromDocument(DocumentSnapshot doc) {
    return PaymentModel(
      userId: doc.get('id'),
      phoneNo: doc.get('phoneNo'),
      transID: doc.get('transID'),
      approved: doc.get('approved'),
      userName: doc.get('userName'),
    );
  }

  PaymentModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    phoneNo = json['phoneNo'];
    transID = json['transID'];
    approved = json['approved'];
    userName = json['userName'];
  }
}
