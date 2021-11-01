class ConsStatusModel {
  ConsStatusModel({
    this.categoryID,
    this.deptName,
    this.title,
    this.consRqstd,
    this.consSlot,
    this.qLastNum,
  });

  factory ConsStatusModel.fromJson(Map<String, dynamic> json) =>
      ConsStatusModel(
        categoryID: json['categoryID'] as String,
        deptName: json['deptName'] as String,
        title: json['title'] as String,
        consRqstd: json['consRqstd'] as int,
        consSlot: json['consSlot'] as int,
        qLastNum: json['qLastNum'] as int,
      );

  Map<String, dynamic> toJson() => {
        'categoryID': categoryID,
        'deptName': deptName,
        'title': title,
        'consRqstd': consRqstd,
        'consSlot': consSlot,
        'qLastNum': qLastNum,
      };

  String? categoryID;
  String? deptName;
  String? title;
  int? consRqstd;
  int? consSlot;
  int? qLastNum;
}
