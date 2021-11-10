import 'dart:ui';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_history_info.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_history_info.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/widgets/bubble_chat.dart';

//TO DO: bubble chat
class DoctorConsHistoryItemScreen extends StatelessWidget {
  static ConsHistoryController consHController = Get.find();
  final ConsultationHistoryModel consData =
      Get.arguments as ConsultationHistoryModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
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
                                bubbleChat(consHController.chatHistory[index]),
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
    if (consHController.getPatientProfile(model) == '') {
      return CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(consHController.getPatientProfile(model)),
    );
  }

//   Widget bubbleChat(ChatModel chat) {
//     if (chat.senderID == auth.currentUser!.uid) {
//       return rightBubbleChat(chat);
//     }
//     return leftBubbleChat(chat);
//   }

//   Widget leftBubbleChat(ChatModel chat) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Flexible(
//           child: Container(
//               constraints: BoxConstraints(maxWidth: Get.width * .7),
//               padding: const EdgeInsets.all(15),
//               decoration: const BoxDecoration(
//                 color: neutralBubbleColor,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   topRight: Radius.circular(10),
//                   bottomRight: Radius.circular(10),
//                 ),
//               ),
//               child: Text(
//                 chat.message!,
//                 style: body16Medium.copyWith(height: 1.4),
//               )),
//         ),
//       ],
//     );
//   }

//   Widget rightBubbleChat(ChatModel chat) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Flexible(
//           child: Container(
//               constraints: BoxConstraints(maxWidth: Get.width * .7),
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: verySoftBlueColor[60],
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   topRight: Radius.circular(10),
//                   bottomLeft: Radius.circular(10),
//                 ),
//               ),
//               child: Text(
//                 chat.message!,
//                 style: body16Medium.copyWith(color: Colors.white, height: 1.4),
//               )),
//         ),
//       ],
//     );
//   }
}
