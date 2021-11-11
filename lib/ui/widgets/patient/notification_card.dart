import 'package:davnor_medicare/core/controllers/patient/notif_controller.dart';
import 'package:davnor_medicare/core/models/notification_model.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:get/get.dart';

//TO THINK: if clickable ba ang notification cards
class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.notif
      //required this.onTap,
      })
      : super(key: key);

  //final void Function()? onTap;
  final NotificationModel notif;
  static NotifController notifController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          verticalSpace10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: getPhoto()),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            style: body14Regular,
                            children: <TextSpan>[
                              TextSpan(
                                  text: notif.from,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              TextSpan(text: notif.action),
                              TextSpan(
                                  text: notif.subject,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        verticalSpace5,
                        Text(
                          notif.message!,
                          style: body14Regular.copyWith(color: Colors.black87),
                        ),
                        verticalSpace10,
                        Text(
                          notifController.convert(notif.createdAt!),
                          style: caption12RegularNeutral,
                        ),
                        verticalSpace10,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget getPhoto() {
    if (notif.photo == '') {
      return CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(notif.photo!),
    );
  }
}
