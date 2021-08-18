import 'package:flutter/material.dart';

class TermsAndPolicyScreen extends StatelessWidget {
  const TermsAndPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text(
            'Terms and Condition',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'These terms and conditions outline the rules and regulators for the use of DavNor Medicare Multi-Platform Application. By accessing this application, we assume you accept these terms and conditions. Do not continue to use this application if you do not agree to take all of the terms and conditions stated on this page. The following terminology applies to these Terms & Conditions, Privacy Policy and Disclaimer Notice and all Agreements: DavNor Medicare (“us”, “we”, or “our”) operates http://www.DavNorMedicare.com. This page informs you of our terms & condition regarding the collection, use and disclosure of Personal Information we receive from users of the application.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
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
          Text(
            'We use your Personal Information only for providing and improving the application. By using this application, you agree to the collection and use of information in accordance with this policy.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
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
          Text(
            'While using our application, we may ask you to provide us with certain personally identifiable information that can be used to contact or identified you. Personally identifiable information may include, but is not limited to your name ("Personal Information").',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
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
          Text(
            'We may terminate or suspend access to our Service Immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
