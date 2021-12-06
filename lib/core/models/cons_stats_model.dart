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
        consRqstd: json['consRqstd'] as dynamic,
        consSlot: json['consSlot'] as dynamic,
        qLastNum: json['qLastNum'] as dynamic,
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
  dynamic consRqstd;
  dynamic consSlot;
  dynamic qLastNum;
}
