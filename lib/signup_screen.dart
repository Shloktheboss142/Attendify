import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  ),
);

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
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
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  // onChanged: (value) {
                  //   password = value;
                  // },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'What should we call you?')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  // onChanged: (value) {
                  //   password = value;
                  // },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Create a password')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter the password again')),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, 'home_screen');
                    }
                  } catch (e) {
                    print(e);
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
                child: const Text('Register',
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



//Confirm Password
//name
