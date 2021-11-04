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
        notifBadge: json['notifBadge'] as String,
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
  final String? notifBadge;
}

class DoctorStatusModel {
  DoctorStatusModel({
    required this.numToAccomodate,
    required this.accomodated,
    required this.dStatus,
    required this.hasOngoingCons,
  });

  factory DoctorStatusModel.fromJson(Map<String, dynamic> json) =>
      DoctorStatusModel(
        numToAccomodate: json['numToAccomodate'] as int,
        accomodated: json['accomodated'] as int,
        dStatus: json['dStatus'] as bool,
        hasOngoingCons: json['hasOngoingCons'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'numToAccomodate': numToAccomodate,
        'accomodated': accomodated,
        'dStatus': dStatus,
        'hasOngoingCons': hasOngoingCons,
      };

  int? numToAccomodate;
  int? accomodated;
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

// class CategoryStatusModel {
//   CategoryStatusModel({
//     this.categoryID,
//     this.consRqstd,
//     this.consSlot,
//     this.deptName,
//     this.qLastNum,
//     this.title,
//   });

//   factory CategoryStatusModel.fromJson(Map<String, dynamic> json) =>
//       CategoryStatusModel(
//         categoryID: json['categoryID'] as String,
//         consRqstd: json['consRqstd'] as int,
//         consSlot: json['consSlot'] as int,
//         deptName: json['deptName'] as String,
//         qLastNum: json['qLastNum'] as int,
//         title: json['title'] as String,
//       );

//   Map<String, dynamic> toJson() => {
//         'categoryID': categoryID,
//         'consRqstd': consRqstd,
//         'consSlot': consSlot,
//         'deptName': deptName,
//         'qLastNum': qLastNum,
//         'title': title,
//       };

//   String? categoryID;
//   int? consRqstd;
//   int? consSlot;
//   String? deptName;
//   int? qLastNum;
//   String? title;
// }
