import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/constants/app_strings.dart';

class TermsAndPolicyScreen extends StatelessWidget {
  const TermsAndPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Terms & Conditions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              termsAndPolicyParagraph1,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 35),
            child: Text(
              'Privacy Policy',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
            child: Text(
              termsAndPolicyParagraph2,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 35),
            child: Text(
              'Information Collection and Use',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
            child: Text(
              termsAndPolicyParagraph3 
,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 35),
            child: Text(
              'Termination',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 35),
            child: Text(
              termsAndPolicyParagraph4,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
        ],
      ),
    );
  }
}
