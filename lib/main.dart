import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
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
                  onPressed: () {
                    if (kIsWeb) {
                      //TODO: Authentication where i check kung nakalogin ba sa web or mobile
                      print(' function where icheck kung unsa na role');
                    } else {
                      print('function na only patient and doctor can login');
                    }
                  },
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
                      //TODO MAKE A DIALOG FOR WEB
                      if (kIsWeb) {
                        print('Show dialog for terms and conditions page');
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Termsandcondition(),
                          ),
                        );
                      }
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
          ElevatedButton(
            onPressed: () {},
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
