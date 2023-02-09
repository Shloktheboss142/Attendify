import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//code for designing the UI of our text field where the user writes his email id or password

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.white),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 168, 175, 255)),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 168, 175, 255)),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ));

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  String passwordText = 'Enter your password';
  var passwordColor = Colors.white;
  String emailText = "Enter your email";
  var emailColor = Colors.white;
  String email = '';
  String password = '';
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: emailText,
                      hintStyle: TextStyle(color: emailColor))),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: passwordText,
                      hintStyle: TextStyle(color: passwordColor))),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pushNamed(context, 'home_screen');
                    }
                  } catch (e) {
                    if (e.toString() ==
                        "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
                      emailText = ("No user found for that email");
                      passwordText = 'Enter your password';
                      passwordColor = Colors.white;
                      emailColor = Colors.red;
                    } else if (e.toString() ==
                        "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
                      passwordText = 'Password incorrect, please try again';
                      emailText = ("Enter your email");
                      emailColor = Colors.white;
                      passwordColor = Colors.red;
                    } else {
                      print(e);
                    }
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width / 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                child: const Text('Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Staatliches',
                        fontSize: 35)),
              ),
              const Text("", style: TextStyle(fontSize: 10)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width / 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                child: const Text('Back',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Staatliches',
                        fontSize: 35)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
