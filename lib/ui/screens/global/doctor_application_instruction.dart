import 'package:flutter/material.dart';



class DoctorApplicationInstructionScreen extends StatelessWidget {
  const DoctorApplicationInstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Join Our Team',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            'Together lets provide healthcare, improve life, and help our community.',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Text(
              'Are you concerned for the health of our community? Extend your care and medical skills by joining as a doctor here in DavNor MediCare. Together we can provide free online consultation, improve everyone’s lives, and feel rewarded for helping others in times of need.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Text(
              'In DavNor MediCare, we only want the best healthcare for our patients. Thats why before accepting clinicians to join our team, we ensure that they are licensed to practice medicine and can provide the level of services we guarantee to our people.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'For Interested Doctors',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),

          Text(
            'Join here',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),

          Text(
            ' For any inquires, please email us at:',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black,
            ),
            ),

            Text(
            'davnor.medicare@gmail.com',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.blue,
            ),
            ),
        ],
      ),
    );
  }
}
