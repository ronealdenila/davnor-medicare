class PatientStatusModel {
  PatientStatusModel(
      {required this.queueMA,
      required this.queueCons,
      required this.deviceToken,
      required this.notifBadge,
      required this.pStatus,
      required this.hasActiveQueueCons,
      required this.hasActiveQueueMA,
      required this.categoryID,
      required this.pendingVerification});

  factory PatientStatusModel.fromJson(Map<String, dynamic> json) =>
      PatientStatusModel(
        categoryID: json['categoryID'] as String,
        queueMA: json['queueMA'] as String,
        queueCons: json['queueCons'] as String,
        deviceToken: json['deviceToken'] as String,
        notifBadge: json['notifBadge'] as int,
        pStatus: json['pStatus'] as bool,
        hasActiveQueueMA: json['hasActiveQueueMA'] as bool,
        hasActiveQueueCons: json['hasActiveQueueCons'] as bool,
        pendingVerification: json['pendingVerification'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'categoryID': categoryID,
        'queueMA': queueMA,
        'queueCons': queueCons,
        'pStatus': pStatus,
        'hasActiveQueueCons': hasActiveQueueCons,
        'hasActiveQueueMA': hasActiveQueueMA,
        'pendingVerification': pendingVerification,
        'deviceToken': deviceToken,
        'notifBadge': notifBadge,
      };

  final String? categoryID;
  final String? queueMA;
  final String? queueCons;
  final bool? hasActiveQueueCons;
  final bool? hasActiveQueueMA;
  final bool? pendingVerification;
  final bool? pStatus;
  final String? deviceToken;
  final int? notifBadge;
}

class DoctorStatusModel {
  DoctorStatusModel({
    required this.numToAccomodate,
    required this.accomodated,
    required this.overall,
    required this.dStatus,
    required this.hasOngoingCons,
  });

  factory DoctorStatusModel.fromJson(Map<String, dynamic> json) =>
      DoctorStatusModel(
        numToAccomodate: json['numToAccomodate'] as int,
        accomodated: json['accomodated'] as int,
        overall: json['overall'] as int,
        dStatus: json['dStatus'] as bool,
        hasOngoingCons: json['hasOngoingCons'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'numToAccomodate': numToAccomodate,
        'accomodated': accomodated,
        'overall': overall,
        'dStatus': dStatus,
        'hasOngoingCons': hasOngoingCons,
      };

  int? numToAccomodate;
  int? accomodated;
  int? overall;
  bool? dStatus;
  bool? hasOngoingCons;
}

class PSWDStatusModel {
  PSWDStatusModel({
    this.hasFunds,
    this.isCutOff,
    this.maRequested,
    this.maSlot,
    this.qLastNum,
  });

  factory PSWDStatusModel.fromJson(Map<String, dynamic> json) =>
      PSWDStatusModel(
        hasFunds: json['hasFunds'] as bool,
        isCutOff: json['isCutOff'] as bool,
        maRequested: json['maRequested'] as int,
        maSlot: json['maSlot'] as int,
        qLastNum: json['qLastNum'] as int,
      );

  Map<String, dynamic> toJson() => {
        'hasFunds': hasFunds,
        'isCutOff': isCutOff,
        'maRequested': maRequested,
        'maSlot': maSlot,
        'qLastNum': qLastNum,
      };

  bool? hasFunds;
  bool? isCutOff;
  int? maRequested;
  int? maSlot;
  int? qLastNum;
}

class IncomingCallModel {
  IncomingCallModel({
    this.channelId,
    this.callerName,
    this.from,
    this.isCalling,
    this.patientJoined,
    this.otherJoined,
    this.didReject,
  });

  factory IncomingCallModel.fromJson(Map<String, dynamic> json) =>
      IncomingCallModel(
        channelId: json['channelId'] as String,
        callerName: json['callerName'] as String,
        from: json['from'] as String,
        isCalling: json['isCalling'] as bool,
        patientJoined: json['patientJoined'] as bool,
        otherJoined: json['otherJoined'] as bool,
        didReject: json['didReject'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'channelId': channelId,
        'callerName': callerName,
        'isCalling': isCalling,
        'from': from,
        'patientJoined': patientJoined,
        'otherJoined': otherJoined,
        'didReject': didReject,
      };

  String? channelId;
  String? callerName;
  String? from;
  bool? isCalling;
  bool? patientJoined;
  bool? otherJoined;
  bool? didReject;
}
