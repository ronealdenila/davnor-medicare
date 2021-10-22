import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PSWDStaffListController extends GetxController {
  final log = getLogger('PSWD Staff List Controller');

  final RxList<PswdModel> pswdList = RxList<PswdModel>();
  final RxList<PswdModel> filteredPswdList = RxList<PswdModel>();
  final TextEditingController pswdFilter = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    getPSWDStaffs().then((value) => pswdList.value = value);
  }

  Future<List<PswdModel>> getPSWDStaffs() async {
    return firestore.collection('pswd_personnel').get().then(
          (query) => query.docs
              .map((item) => PswdModel.fromJson(item.data()))
              .toList(),
        );
  }
}
