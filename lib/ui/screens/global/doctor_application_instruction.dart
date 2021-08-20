import 'package:flutter/material.dart';



class DoctorApplicationInstructionScreen extends StatelessWidget {
  const DoctorApplicationInstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Join Our Team',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child:
          Text(
            'Together lets provide healthcare, improve life, and help our community.',
            textAlign: TextAlign.center,
          ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 35),
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
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 35),
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
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
            ),

        Padding(
          padding: EdgeInsets.symmetric( horizontal: 35),
          child: Text(
            'For Interested Doctors:',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),

          Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
          child: Text(
            'Join us here',
            textAlign: TextAlign.left,
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationThickness: 1,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.blue,
            ),
            ),
          ),
          
          Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
        ),

          Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
          child: Text(
            'For any inquiries, please email us at:',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),

          Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
          child: Text(
            'davnor.medicare@gmail.com',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.blue,
            ),
            ),
          ),
            
        ],
      ),
    );
  }
}
