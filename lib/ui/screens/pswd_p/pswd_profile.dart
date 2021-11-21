import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/auth/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PSWDProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(child: ResponsiveView(context))),
    );
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView(this.context) : super(alwaysUseBuilder: false);
  final BuildContext context;
  static AuthController authController = Get.find();
  final fetchedData = authController.pswdModel.value;

  @override
  Widget phone() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              verticalSpace35,
              profileDetails(context),
            ]),
          )
        ],
      );

  @override
  Widget tablet() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              verticalSpace35,
              profileDetails(context),
            ]),
          )
        ],
      );

  @override
  Widget desktop() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: screen.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              verticalSpace35,
              profileDetails(context),
            ]),
          ),
        ],
      );

  Widget profileDetails(BuildContext context) {
    return Center(
      child: Column(
        children: [
          verticalSpace50,
          displayProfile(),
          verticalSpace18,
          Text(
            fetchedData!.firstName!,
            style: body16Bold,
          ),
          verticalSpace10,
          Text(
            fetchedData!.email!,
            style: body16Regular,
          ),
          verticalSpace50,
          Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            const Icon(Icons.lock_outline),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => changePasswordDialog(context));
              },
              child: const Text(
                'Change Password',
                style: body16Regular,
              ),
            ),
          ])
        ],
      ),
    );
  }

  Widget displayProfile() {
    return StreamBuilder<DocumentSnapshot>(
        stream: firestore
            .collection('pswd_personnel')
            .doc(auth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return CircleAvatar(
              radius: 115,
              backgroundImage: AssetImage(blankProfile),
            );
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          if (data['profileImage'] == '') {
            return CircleAvatar(
              radius: 115,
              backgroundImage: AssetImage(blankProfile),
            );
          }
          return CircleAvatar(
            radius: 115,
            foregroundImage: NetworkImage(data['profileImage']),
            backgroundImage: AssetImage(blankProfile),
          );
        });
  }

  Widget changePasswordDialog(BuildContext context) {
    final AuthController authController = Get.find();
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 50,
        ),
        children: [
          SizedBox(
            width: Get.width * .2,
            child: Column(
              children: [
                verticalSpace25,
                const Text(
                  'Change Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                verticalSpace10,
                const Text(
                  changePasswordDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: neutralColor),
                ),
                verticalSpace50,
                Obx(
                  () => FormInputFieldWithIcon(
                    controller: authController.currentPasswordController,
                    iconPrefix: Icons.vpn_key_rounded,
                    labelText: 'Current Password',
                    maxLines: 1,
                    obscureText: authController.isObscureCurrentPW!.value,
                    onChanged: (value) {
                      return;
                    },
                    onSaved: (value) =>
                        authController.currentPasswordController.text = value!,
                    suffixIcon: IconButton(
                      onPressed: authController.toggleCurrentPasswordVisibility,
                      icon: Icon(
                        authController.isObscureCurrentPW!.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    validator: Validator().password,
                  ),
                ),
                verticalSpace25,
                Obx(
                  () => FormInputFieldWithIcon(
                    controller: authController.newPasswordController,
                    iconPrefix: Icons.vpn_key_rounded,
                    labelText: 'New Password',
                    onChanged: (value) {
                      return;
                    },
                    maxLines: 1,
                    obscureText: authController.isObscureNewPW!.value,
                    onSaved: (value) =>
                        authController.newPasswordController.text = value!,
                    suffixIcon: IconButton(
                      onPressed: authController.toggleNewPasswordVisibility,
                      icon: Icon(
                        authController.isObscureNewPW!.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    validator: Validator().password,
                  ),
                ),
                verticalSpace25,
                CustomButton(
                  onTap: () async {
                    await authController.changePassword(context);
                  },
                  text: 'Change Password',
                  buttonColor: verySoftBlueColor,
                ),
              ],
            ),
          )
        ]);
  }
}
