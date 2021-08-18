import 'package:davnor_medicare/core/services/navigation_service.dart';
import 'package:davnor_medicare/locator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'routes.dart' as router;
import 'constants/route_paths.dart' as routes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Register all the models and services before the app starts
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: Termsandcondition(),
    );
  }
}

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Text("Login Page"),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
                  child: kIsWeb
                      ? Placeholder()
                      : Image.asset(
                          'asset/images/auth_header.png',
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              Text(
                'Welcome Back!',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: kIsWeb ? 40 : 25),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                  },
                  child: Text(
                    'Forgot Password',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Dont have an account?',
                  ),
                  TextButton(
                    onPressed: () {
                      //TODO FORGOT PASSWORD SCREEN GOES HERE
                    },
                    child: Text(
                      'Signup here',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//ForgotPassword
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text(
            'Recover Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Request Password Reset'),
          ),
        ],
      ),
    );
  }
}

//termsandCondition
class Termsandcondition extends StatefulWidget {
  const Termsandcondition({Key? key}) : super(key: key);

  @override
  _TermsandconditionState createState() => _TermsandconditionState();
}

class _TermsandconditionState extends State<Termsandcondition> {
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
              style: TextStyle(fontSize: 15,
              fontWeight: FontWeight.normal,
              ),
              ),
      ],
      ),
      
      );

    }
}

//Join Our Team
class Joinourteam extends StatefulWidget {
  const Joinourteam({ Key? key }) : super(key: key);

  @override
  _JoinourteamState createState() => _JoinourteamState();
}

class _JoinourteamState extends State<Joinourteam> {
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

              Text(
                'Join here',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
      ],
      ),
=======
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: routes.LoginRoute,
      onGenerateRoute: router.generateRoute,
>>>>>>> 70d330d445e854b9f817e4e32db30661a87e7b55
    );
  }
}
