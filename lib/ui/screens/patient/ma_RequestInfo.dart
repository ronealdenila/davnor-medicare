import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MARequestInfoScreen extends StatelessWidget {
  const MARequestInfoScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white,
      body: ListView(
              children: <Widget>[
                Padding(padding:
                 EdgeInsets.only( top: 45, left: 16),
                   child: Text(
                    'Patients Information',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.w600,
                     color: Colors.grey,
                ),
              ),
            ),

            Padding(padding:
                 EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                   child: Text(
                    'Patients Name',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.w700,
                     color: Colors.black,
                ),
              ),
            ),

            Padding(padding:
                 EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                   child: Text(
                    'Patients Age',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.w700,
                     color: Colors.black,
                ),
              ),
            ),

            Padding(padding:
                 EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                   child: Text(
                    'Address',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.w700,
                     color: Colors.black,
                ),
              ),
            ),

            Padding(padding:
                 EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                   child: Text(
                    'Gender',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.w700,
                     color: Colors.black,
                ),
              ),
            ),

            Padding(padding:
                 EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                   child: Text(
                    'Patients Type',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.w700,
                     color: Colors.black,
                ),
              ),
            ),
            
            Padding(padding:
                 EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                   child: Text(
                    'MA Request Information',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.w600,
                     color: Colors.grey,
                ),
              ),
            ),

            Padding(padding:
                 EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                   child: Text(
                    'Received by',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.w700,
                     color: Colors.black,
                ),
              ),
            ),

            Padding(padding:
                 EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                   child: Text(
                    'Pharmacy',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.w700,
                     color: Colors.black,
                ),
              ),
            ),

            Padding(padding:
                 EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                   child: Text(
                    'Medecine Worth',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.w700,
                     color: Colors.black,
                ),
              ),
            ),

            Padding(padding:
                 EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                   child: Text(
                    'Date Requested',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.w700,
                     color: Colors.black,
                ),
              ),
            ),

            Padding(padding:
                 EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                   child: Text(
                    'Date MA Claimed',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.w700,
                     color: Colors.black,
                ),
              ),
            ),

            Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                             'See attached photos',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

          ],
        ),
        ),
      );
  }
}