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
    required this.dStatus,
    required this.hasOngoingCons,
  });

  factory DoctorStatusModel.fromJson(Map<String, dynamic> json) =>
      DoctorStatusModel(
        numToAccomodate: json['numToAccomodate'] as int,
        dStatus: json['dStatus'] as bool,
        hasOngoingCons: json['hasOngoingCons'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'numToAccomodate': numToAccomodate,
        'dStatus': dStatus,
        'hasOngoingCons': hasOngoingCons,
      };

  int? numToAccomodate;
  bool? dStatus;
  bool? hasOngoingCons;
}
