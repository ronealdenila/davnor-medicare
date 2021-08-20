import 'package:davnor_medicare/core/controllers/authController.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/global/forgot_password.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginWidget extends GetWidget<AuthController> {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FormInputFieldWithIcon(
                  controller: authController.emailController,
                  iconPrefix: Icons.email,
                  labelText: 'Email',
                  validator: Validator().email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      authController.emailController.text = value!,
                ),
                verticalSpace25,
                FormInputFieldWithIcon(
                  controller: authController.passwordController,
                  iconPrefix: Icons.lock,
                  labelText: 'Password',
                  validator: Validator().password,
                  obscureText: true,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      authController.passwordController.text = value!,
                  maxLines: 1,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(ForgotPasswordScreen());
                    },
                    child: Text('Forgot Password'),
                    style: TextButton.styleFrom(primary: kcInfoColor),
                  ),
                ),
                verticalSpace25,
                CustomButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      authController.signInWithEmailAndPassword(context);
                    }
                  },
                  text: 'Sign In',
                  color: kcVerySoftBlueColor,
                  fontSize: 20,
                ),
                verticalSpace25,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Wrap(
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 30),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Text(
//               'Welcome Back',
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width / 1.2,
//               margin: EdgeInsets.only(top: 30),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 color: Colors.grey.withOpacity(.3),
//               ),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 child: TextField(
//                   controller: authController.emailController,
//                   decoration: InputDecoration(
//                       icon: Icon(Icons.email_outlined),
//                       fillColor: Colors.white,
//                       border: InputBorder.none,
//                       labelText: 'Email',
//                       //Suggestion(R): Maybe pamub-an ang hint text? or patas-on ang container
//                       hintText: 'Enter valid email id as abc@gmail.com'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width / 1.2,
//               margin: EdgeInsets.only(top: 30),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 color: Colors.grey.withOpacity(.3),
//               ),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 child: TextField(
//                   controller: authController.passwordController,
//                   decoration: InputDecoration(
//                     icon: Icon(Icons.lock),
//                     fillColor: Colors.white,
//                     border: InputBorder.none,
//                     labelText: 'Password',
//                     hintText: 'Enter secure password',
//                     //TODO: Make it toggleable
//                     suffixIcon: Icon(Icons.remove_red_eye),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Align(
//           alignment: Alignment.centerRight,
//           child: Padding(
//             padding: const EdgeInsets.only(right: 20),
//             child:
//                 TextButton(onPressed: () {}, child: Text('Forgot Password')),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Align(
//             alignment: Alignment.center,
//             child: Container(
//               height: 50,
//               width: 250,
//               decoration: BoxDecoration(
//                   color: kcVerySoftBlueColor[20],
//                   borderRadius: BorderRadius.circular(10)),
//               child: TextButton(
//                 onPressed: () {
//                   //For testing. Use this accounts
//                   //PSWD Staff:  pswd@gmail.com //Admin: admin@gmail.com
//                   //Patient: patient@gmail.com //Doctor: doctor@gmail.com
//                   authController.signInWithEmailAndPassword(context);
//                 },
//                 child: Text(
//                   'Sign in',
//                   style: TextStyle(color: Colors.white, fontSize: 25),
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
