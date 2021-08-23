//User Model
import 'package:cloud_firestore/cloud_firestore.dart';


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
