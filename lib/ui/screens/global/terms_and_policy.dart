import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TermsAndPolicyScreen extends StatefulWidget {
  const TermsAndPolicyScreen({Key? key}) : super(key: key);

  @override
  _TermsAndPolicyScreenState createState() => _TermsAndPolicyScreenState();
}

class _TermsAndPolicyScreenState extends State<TermsAndPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Terms and Condition Page'),
        ),
        body: Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text('Terms and Condition'),
                ),
                Text(
                  'These terms and conditions outline the rules and regulators for the use of DavNor Medicare Multi-Platform Application. By accessing this application, we assume you accept these terms and conditions. Do not continue to use this application if you do not agree to take all of the terms and conditions stated on this page.',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: kIsWeb ? 15 : 20),
                ),
              ],
            )),
      ),
    );
  }
}
