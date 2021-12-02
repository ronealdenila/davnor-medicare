import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_history_info.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/ui/widgets/bubble_chat.dart';

class DoctorConsHistoryItemScreen extends StatelessWidget {
  final ConsHistoryController consHController = Get.find();
  final ConsultationHistoryModel consData =
      Get.arguments as ConsultationHistoryModel;

  final RxBool errorPhoto = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 1,
          title: Row(
            children: [
              Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: getPhoto(consData)),
              horizontalSpace15,
              Expanded(
                child: Text(
                  consHController.getPatientName(consData),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: subtitle18Medium.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.info_outline,
                size: 30,
              ),
              onPressed: () => Get.to(() => HistoryInfoScreen(),
                  arguments: consData, transition: Transition.rightToLeft),
            ),
            horizontalSpace10,
          ],
        ),
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FutureBuilder(
                    future: consHController.getChatHistory(consData),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
                          shrinkWrap: true,
                          itemCount: consHController.chatHistory.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                bubbleChat(consHController.chatHistory[index],
                                    context),
                                verticalSpace15
                              ],
                            );
                          },
                        );
                      }
                      return const Text('Loading ..');
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPhoto(ConsultationHistoryModel model) {
    return CircleAvatar(
        radius: 25,
        foregroundImage: NetworkImage(consHController.getPatientProfile(model)),
        onForegroundImageError: (_, __) {
          errorPhoto.value = true;
        },
        backgroundColor: Colors.grey,
        child: Obx(
          () => errorPhoto.value
              ? Text(
                  '${consHController.getPatientFirstName(model)[0]}',
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
        ));
  }
}
