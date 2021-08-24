//User Model
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// if dili magbutang og required mag fetch sa firestore kahit null ang value
class UserModel {
  UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.hasActiveQueue,
    this.pStatus,
    this.profileImage,
    this.userType,
    this.validId,
  });

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    email = (snapshot.data() as dynamic)['email'] as String;
    firstName = (snapshot.data() as dynamic)['firstName'] as String;
    lastName = (snapshot.data() as dynamic)['lastName'] as String;
    hasActiveQueue = (snapshot.data() as dynamic)['hasActiveQueue'] as bool;
    pStatus = (snapshot.data() as dynamic)['pStatus'] as bool;
    profileImage = (snapshot.data() as dynamic)['profileImage'] as String;
    userType = (snapshot.data() as dynamic)['userType'] as String;
    validId = (snapshot.data() as dynamic)['validID'] as String;
  }

  String? email;
  String? firstName;
  String? lastName;
  bool? hasActiveQueue;
  bool? pStatus;
  String? profileImage;
  String? userType;
  String? validId;
}

class DoctorModel {
  DoctorModel({
    this.email,
    this.firstName,
    this.lastName,
    this.dStatus,
  });

  DoctorModel.fromSnapshot(DocumentSnapshot snapshot) {
    email = (snapshot.data() as dynamic)['email'] as String;
    firstName = (snapshot.data() as dynamic)['firstName'] as String;
    lastName = (snapshot.data() as dynamic)['lastName'] as String;
    dStatus = (snapshot.data() as dynamic)['dStatus'] as bool;
  }

  String? email;
  String? firstName;
  String? lastName;
  bool? dStatus;
}

class AdminModel {
  AdminModel({
    this.email,
    this.firstName,
    this.lastName,
    this.dStatus,
  });

  AdminModel.fromSnapshot(DocumentSnapshot snapshot) {
    email = (snapshot.data() as dynamic)['email'] as String;
    firstName = (snapshot.data() as dynamic)['firstName'] as String;
    lastName = (snapshot.data() as dynamic)['lastName'] as String;
  }

  String? email;
  String? firstName;
  String? lastName;
  bool? dStatus;
}

class PswdHModel {
  PswdHModel({
    this.email,
    this.firstName,
    this.lastName,
    this.dStatus,
  });

  PswdHModel.fromSnapshot(DocumentSnapshot snapshot) {
    email = (snapshot.data() as dynamic)['email'] as String;
    firstName = (snapshot.data() as dynamic)['firstName'] as String;
    lastName = (snapshot.data() as dynamic)['lastName'] as String;
  }

  String? email;
  String? firstName;
  String? lastName;
  bool? dStatus;
}
