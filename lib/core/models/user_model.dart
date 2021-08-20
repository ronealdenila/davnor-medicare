//User Model
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  bool? hasActiveQueue;
  bool? pStatus;
  String? profileImage;
  String? userType;
  String? validID;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.hasActiveQueue,
    this.pStatus,
    this.profileImage,
    this.userType,
    this.validID,
  });

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    firstName = (snapshot.data() as dynamic)["firstName"];
    lastName = (snapshot.data() as dynamic)["lastName"];
    email = (snapshot.data() as dynamic)["email"];
    hasActiveQueue = (snapshot.data() as dynamic)["hasActiveQueue"];
    pStatus = (snapshot.data() as dynamic)["pStatus"];
    profileImage = (snapshot.data() as dynamic)["profileImage"];
    userType = (snapshot.data() as dynamic)["userType"];
    validID = (snapshot.data() as dynamic)["validID"];
  }
}
