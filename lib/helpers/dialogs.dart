import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/dialog_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoading() {
  Get.defaultDialog(
      title: 'Loading...',
      content: const CircularProgressIndicator(),
      barrierDismissible: false);
}

void showErrorDialog({
  String? errorTitle,
  String? errorDescription,
}) {
  Get.defaultDialog(
    title: errorTitle!,
    middleText: errorDescription!,
    textConfirm: 'Okay',
    confirmTextColor: Colors.white,
    onConfirm: Get.back,
  );
}

void showDefaultDialog({
  String? dialogTitle,
  String? dialogCaption,
  String? textConfirm = 'Got it!',
  void Function()? onConfirmTap,
}) {
  //wala pako kaexplore sa ubang parameter sadefault dialog pero limit ra
  //ang pag configure sa dialog niya if gusto nato i custom ni pwede ta mag
  //dialog parehas sa akong gibuhat sa showConfirmationDialog (R)
  Get.defaultDialog(
    radius: 8,
    titleStyle: title24Bold,
    titlePadding: const EdgeInsets.all(10),
    title: dialogTitle!,
    content: Text(
      dialogCaption!,
      style: body16SemiBold.copyWith(
        color: neutralColor,
      ),
      textAlign: TextAlign.center,
    ),
    onConfirm: onConfirmTap,
    textConfirm: textConfirm,
    confirmTextColor: Colors.white,
  );
}

void showConfirmationDialog({
  String? dialogTitle,
  String? dialogCaption,
  Function()? onYesTap,
  Function()? onNoTap,
}) {
  Get.dialog(
    //TODO(R): Refactor so that it wil be on widget folder
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            height: 284,
            width: 343,
            padding: const EdgeInsets.only(
              top: 18,
            ),
            margin: const EdgeInsets.only(top: 13, right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    //Note: If magbutang kog horizontal padding kay mag 3 lines
                  ),
                  child: Text(
                    dialogTitle!,
                    style: title24Bold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    dialogCaption!,
                    style: body16SemiBold.copyWith(color: neutralColor[60]),
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalSpace10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DialogButton(
                      buttonText: 'Yes',
                      onTap: onYesTap,
                    ),
                    DialogButton(
                      buttonText: 'No',
                      onTap: onNoTap,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: GestureDetector(
              onTap: Get.back,
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14,
                  //TO BE REGISTERED ON APP COLOR
                  backgroundColor: const Color(0xFFE3E6E8),
                  child: Icon(Icons.close, color: neutralColor[100]),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void dismissDialog() {
  Get.back();
}
