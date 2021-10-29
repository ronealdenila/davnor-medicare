//User Model

class PatientModel {
  PatientModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.validID,
    required this.validSelfie,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        profileImage: json['profileImage'] as String,
        validID: json['validID'] as String,
        validSelfie: json['validSelfie'] as String,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'profileImage': profileImage,
        'validID': validID,
        'validSelfie': validSelfie,
      };

  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final String? validID;
  final String? validSelfie;
}

class DoctorModel {
  DoctorModel({
    required this.userID,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.department,
    required this.clinicHours,
    required this.profileImage,
    required this.numToAccomodate,
    required this.dStatus,
    required this.hasOngoingCons,
    required this.disabled,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        userID: json['userID'] as String,
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        title: json['title'] as String,
        department: json['department'] as String,
        clinicHours: json['clinicHours'] as String,
        profileImage: json['profileImage'] as String,
        numToAccomodate: json['numToAccomodate'] as int,
        dStatus: json['dStatus'] as bool,
        hasOngoingCons: json['hasOngoingCons'] as bool,
        disabled: json['disabled'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'title': title,
        'department': department,
        'clinicHours': clinicHours,
        'profileImage': profileImage,
        'numToAccomodate': numToAccomodate,
        'dStatus': dStatus,
        'hasOngoingCons': hasOngoingCons,
        'disabled': disabled,
      };

  String? userID;
  String? email;
  String? firstName;
  String? lastName;
  String? title;
  String? department;
  String? clinicHours;
  String? profileImage;
  int? numToAccomodate;
  bool? dStatus;
  bool? hasOngoingCons;
  bool? disabled;
}

class AdminModel {
  AdminModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        profileImage: json['profileImage'] as String,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'profileImage': profileImage,
      };
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage; //data that will change
}

class PswdModel {
  PswdModel({
    required this.userID,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.profileImage,
    required this.disabled,
  });

  factory PswdModel.fromJson(Map<String, dynamic> json) => PswdModel(
        userID: json['userID'] as String,
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        position: json['position'] as String,
        profileImage: json['profileImage'] as String,
        disabled: json['disabled'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'position': position,
        'profileImage': profileImage,
        'disabled': disabled,
      };

  String? userID;
  String? email;
  String? firstName;
  String? lastName;
  String? position;
  bool? disabled;
  String? profileImage;
}
