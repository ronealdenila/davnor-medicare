import 'package:davnor_medicare/core/controllers/authController.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/doctor/home.dart';
import 'package:davnor_medicare/ui/screens/global/doctor_application_instruction.dart';
import 'package:davnor_medicare/ui/screens/global/terms_and_policy.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/bottom_text.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupWidget extends GetWidget<AuthController> {
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
                  controller: authController.firstNameController,
                  iconPrefix: Icons.person,
                  labelText: 'First Name',
                  validator: Validator().name,
                  keyboardType: TextInputType.name,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      authController.firstNameController.text = value!,
                ),
                verticalSpace10,
                FormInputFieldWithIcon(
                  controller: authController.lastNameController,
                  iconPrefix: Icons.person,
                  labelText: 'Last Name',
                  validator: Validator().name,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      authController.lastNameController.text = value!,
                ),
                verticalSpace10,
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
                verticalSpace10,
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
                verticalSpace10,
                FormInputFieldWithIcon(
                  controller: authController.passwordController,
                  iconPrefix: Icons.lock,
                  labelText: 'Confirm Password',
                  //TODO: Create a validator where
                  //password controller and confirm passwordcontroller has same value
                  validator: Validator().password,
                  obscureText: true,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      authController.passwordController.text = value!,
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? newValue) {},
                    ),
                    BottomTextWidget(
                      onTap: () {
                        Get.to(TermsAndPolicyScreen());
                      },
                      text1: 'I agree to',
                      text2: 'Terms & Condition',
                    )
                  ],
                ),
                verticalSpace10,
                CustomButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      authController.registerWithEmailAndPassword(context);
                    }
                  },
                  text: 'Sign Up Now',
                  color: kcVerySoftBlueColor,
                  fontSize: 20,
                ),
                verticalSpace10,
                Align(
                  alignment: Alignment.center,
                  child: BottomTextWidget(
                    onTap: () {
                      Get.to(DoctorApplicationInstructionScreen());
                    },
                    text1: 'Are you a doctor?',
                    text2: 'Join us now!',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Container(
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(.5),
//               blurRadius: 10,
//             )
//           ],
//           borderRadius: BorderRadius.circular(20)),
//       child: Wrap(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 20),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Text(
//                 'Sign Up',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width / 1.2,
//                 margin: EdgeInsets.only(top: 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Colors.grey.withOpacity(.3),
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   child: TextField(
//                     controller: authController.firstNameController,
//                     textInputAction: TextInputAction.next,
//                     decoration: InputDecoration(
//                         icon: Icon(Icons.person),
//                         fillColor: Colors.white,
//                         border: InputBorder.none,
//                         labelText: 'First Name',
//                         hintText: 'Enter valid first name'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width / 1.2,
//                 margin: EdgeInsets.only(top: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Colors.grey.withOpacity(.3),
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   child: TextField(
//                     controller: authController.lastNameController,
//                     textInputAction: TextInputAction.next,
//                     decoration: InputDecoration(
//                         icon: Icon(Icons.person),
//                         fillColor: Colors.white,
//                         border: InputBorder.none,
//                         labelText: 'Last Name',
//                         hintText: 'Enter valid last name'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width / 1.2,
//                 margin: EdgeInsets.only(top: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Colors.grey.withOpacity(.3),
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   child: TextField(
//                     controller: authController.emailController,
//                     textInputAction: TextInputAction.next,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                         icon: Icon(Icons.email_outlined),
//                         fillColor: Colors.white,
//                         border: InputBorder.none,
//                         labelText: 'Email',
//                         //Suggestion(R): Maybe pamub-an ang hint text? or patas-on ang container
//                         hintText: 'Enter valid email id as abc@gmail.com'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width / 1.2,
//                 margin: EdgeInsets.only(top: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Colors.grey.withOpacity(.3),
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   child: TextField(
//                     controller: authController.passwordController,
//                     textInputAction: TextInputAction.next,
//                     decoration: InputDecoration(
//                       icon: Icon(Icons.lock),
//                       fillColor: Colors.white,
//                       border: InputBorder.none,
//                       labelText: 'Password',
//                       hintText: 'Enter secure password',
//                       //TODO: Make it toggleable
//                       suffixIcon: Icon(Icons.remove_red_eye),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width / 1.2,
//                 margin: EdgeInsets.only(top: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Colors.grey.withOpacity(.3),
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                   child: TextField(
//                     controller: authController.passwordController,
//                     decoration: InputDecoration(
//                       icon: Icon(Icons.lock),
//                       fillColor: Colors.white,
//                       border: InputBorder.none,
//                       labelText: 'Confirm Password',
//                       hintText: 'Please Confirm your password',
//                       //TODO: Make it toggleable
//                       //PS: suffixicon is not appropriate for toggling obscure text
//                       //kay everytime iclick siya magsabay siya sa input text
//                       suffixIcon: Icon(Icons.remove_red_eye),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Checkbox(
//                 value: false,
//                 onChanged: (bool? newValue) {},
//               ),
//               BottomTextWidget(
//                 onTap: () {},
//                 text1: 'I agree to',
//                 text2: 'Terms & Condition',
//               )
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Align(
//               alignment: Alignment.center,
//               child: Container(
//                 height: 50,
//                 width: 250,
//                 decoration: BoxDecoration(
//                     color: kcVerySoftBlueColor,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: TextButton(
//                   onPressed: () {
//                     //For testing. Use this accounts
//                     //PSWD Staff:  pswd@gmail.com //Admin: admin@gmail.com
//                     //Patient: patient@gmail.com //Doctor: doctor@gmail.com
//                     authController.signInWithEmailAndPassword(context);
//                   },
//                   child: Text(
//                     'Sign Up Now',
//                     style: TextStyle(color: Colors.white, fontSize: 25),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: BottomTextWidget(
//                 onTap: () {},
//                 text1: 'Are you a doctor?',
//                 text2: 'Join us now!',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );