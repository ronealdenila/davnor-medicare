import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/logger_service.dart.dart';
import 'package:davnor_medicare/core/models/verification_req_model.dart';
import 'package:get/get.dart';

//To be rename
class VerificationRequestController extends GetxController {
  final log = getLogger('Admin Verification Request Controller');

  RxList<VerificationReqModel> verifReq = RxList<VerificationReqModel>();

  @override
  void onReady() {
    super.onReady();
    verifReq.bindStream(getVfRequestList());
  }

  Stream<List<VerificationReqModel>> getVfRequestList() {
    log.i('Admin Verification Request Controller | getVfRequestList');
    return firestore
        .collection('to_verify')
        .orderBy('dateRqstd', descending: false)
        .snapshots()
        .map(
          (query) => query.docs
              .map((item) => VerificationReqModel.fromJson(item.data()))
              .toList(),
        );
  }
}
