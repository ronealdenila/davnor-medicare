class UserData {
  String? userID, firstName, lastName, email, profileImage; //Shared Fields

  String? validID, validSelfie; //Patient Data
  bool? pStatus, hasActiveQueue;

  String? title, department, clinicHours; //Doctor Data
  int? numToAccomodate;
  bool? dStatus, hasOngoingCons;

  String? position; //PSWD Personnel Data

  UserData.forPatient(
      {this.userID,
      this.firstName,
      this.lastName,
      this.email,
      this.profileImage,
      this.pStatus,
      this.validID,
      this.validSelfie,
      this.hasActiveQueue});

  UserData.forDoctor(
      {this.userID,
      this.firstName,
      this.lastName,
      this.email,
      this.profileImage,
      this.dStatus,
      this.title,
      this.department,
      this.clinicHours,
      this.numToAccomodate,
      this.hasOngoingCons});

  UserData.forPSWD(
      {this.userID,
      this.firstName,
      this.lastName,
      this.email,
      this.profileImage,
      this.position});

  UserData.forAdmin(
      {this.userID,
      this.firstName,
      this.lastName,
      this.email,
      this.profileImage});

  @override
  String toString() {
    return 'Data: {userID: $userID, firstName: $firstName, lastName: $lastName, email: $email}';
  }

  String? getFirstName() {
    return this.firstName;
  }
}
