import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: Authentication(),
    );
  }
}

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  String? userRole;

  void auth() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
          email: "doctor@gmail.com",
          password: "123456"); //TODO: get value from text field
      await getUserRole();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  getUserRole() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance //get user roles
          .collection('users')
          .doc(currentUser.uid)
          .get()
          .then(
        (DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            userRole = documentSnapshot["usertype"];
            print('User Type: ' +
                userRole!); //TODO: Store data in user object puhon
            print('First Name: ' + documentSnapshot["firstname"]);
            print('Last Name: ' + documentSnapshot["lastname"]);
          }
        },
      );
      await checkUserPlatform();
    }
  }

  checkUserPlatform() async {
    if (kIsWeb) {
      //Web Platform
      switch (userRole) {
        case 'pswd-p':
          print('Logged in as PSWD Personnel'); //TODO: Navigate pswd personnel
          break;
        case 'pswd-h':
          print('Logged in as PSWD Head'); //TODO: Navigate to pswd head screen
          break;
        case 'admin':
          print('Logged in as Admin'); //TODO: Navigate to admin screen
          break;
        case 'doctor':
          print('Logged in as doctor'); //TODO: Navigate to doctor screen
          break;
        case 'patient':
          print('Logged in as patient'); //TODO: Navigate to patient screen
          break;
        default:
          print('Error Occured'); //TODO: Error Dialog
      }
    } else {
      //Mobile Platform
      if (userRole == 'pswd-p' || userRole == 'pswd-h' || userRole == 'admin') {
        print('Please log in on Web Application'); //TODO: Error Dialog
      } else {
        switch (userRole) {
          case 'doctor':
            print('Logged in as doctor'); //TODO: Navigate to doctor screen
            break;
          case 'patient':
            print('Logged in as patient'); //TODO: Navigate to patient screen
            break;
          default:
            print('Error Occured'); //TODO: Error Dialog
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
                  child: Image.asset(
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ForgotPasswordScreen(),
                      ),
                    );
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
                  onPressed: auth,
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Termsandcondition(),
                        ),
                      );
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
                //TODO: Navigate to Forgot Pass Screen
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
            onPressed: () {
              //TODO: function for change pass
            },
            child: Text('Request Password Reset'),
          ),
        ],
      ),
    );
  }
}

class Termsandcondition extends StatefulWidget {
  const Termsandcondition({Key? key}) : super(key: key);

  @override
  _TermsandconditionState createState() => _TermsandconditionState();
}

class _TermsandconditionState extends State<Termsandcondition> {
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
