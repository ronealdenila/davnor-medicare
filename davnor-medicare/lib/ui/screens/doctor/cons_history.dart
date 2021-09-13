import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/consultation_card.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';

// ignore: must_be_immutable
class DocConsHistoryScreen extends StatelessWidget {
  //static AuthController authController = Get.find();
  TextEditingController searchKeyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: verySoftBlueColor,
        ),
        backgroundColor: verySoftBlueColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpace20,
                    const Text('Consultation History', style: title24BoldWhite),
                    verticalSpace20,
                    Row(children: [
                      SizedBox(
                        height: 50,
                        width: screenWidthPercentage(context, percentage: .5),
                        child: TextFormField(
                          controller: searchKeyword,
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Search here...'),
                          onChanged: (value) {
                            return;
                          },
                          onSaved: (value) => searchKeyword.text = value!,
                        ),
                      ),
                      horizontalSpace10,
                      InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: verySoftBlueColor[100],
                            ),
                            child: const Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]),
            ),
            verticalSpace35,
            Expanded(
              child: Container(
                width: screenWidth(context),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                  ),
                ),
                // child: Padding(
                //   padding: const EdgeInsets.only(
                //     top: 25,
                //   ),
                //   child: ListView.builder(
                //     padding: const EdgeInsets.symmetric(
                //         vertical: 10, horizontal: 30),
                //     shrinkWrap: true,
                //     itemCount: 6,
                //     itemBuilder: (context, index) {
                //       return ConsultationCard(
                //           title: 'Howard Wolowitz',
                //           subtitle: 'Consultation Date:',
                //           data: 'July 27, 2021 (11:40 am)',
                //           profileImage:
                //               'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
                //           onTap: () {});
                //     },
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
