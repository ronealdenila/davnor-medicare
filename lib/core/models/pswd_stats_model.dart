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
