class PatientStatusModel {
  PatientStatusModel(
      {required this.queueNum,
      required this.deviceToken,
      required this.notifBadge,
      required this.pStatus,
      required this.hasActiveQueue,
      required this.pendingVerification});

  factory PatientStatusModel.fromJson(Map<String, dynamic> json) =>
      PatientStatusModel(
        queueNum: json['queueNum'] as String,
        deviceToken: json['deviceToken'] as String,
        notifBadge: json['notifBadge'] as String,
        pStatus: json['pStatus'] as bool,
        hasActiveQueue: json['hasActiveQueue'] as bool,
        pendingVerification: json['pendingVerification'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'queueNum': queueNum,
        'pStatus': pStatus,
        'hasActiveQueue': hasActiveQueue,
        'pendingVerification': pendingVerification,
        'deviceToken': deviceToken,
        'notifBadge': notifBadge,
      };

  final String? queueNum;
  final bool? hasActiveQueue;
  final bool? pendingVerification;
  final bool? pStatus;
  final String? deviceToken;
  final String? notifBadge;
}
