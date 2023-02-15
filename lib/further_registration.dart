import 'dart:math';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:firebase_database/firebase_database.dart';

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

class FurtherRegistration extends StatefulWidget {
  const FurtherRegistration({super.key});

  @override
  _FurtherRegistration createState() => _FurtherRegistration();
}

class _FurtherRegistration extends State<FurtherRegistration> {
  String name = '';
  String location = '';
  String education = '';
  String experience = '';
  String subject = '';
  String about = '';
  bool showSpinner = false;
  bool submit = false;
  final TextEditingController controller = TextEditingController();
  var db = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      setState(() {
        submit = controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 43, 78),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: controller,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'What should we call you?',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    location = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Where are you situated? (optional)',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    education = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Educational background (optional)',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    experience = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Years of experience (optional)',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    subject = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'What subject(s) do you teach? (optional)',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    about = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Give some info about yourself (optional)',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              const SizedBox(
                height: 40.0,
              ),
              ElevatedButton(
                onPressed: submit
                    ? () async {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');

                        setState(() {
                          showSpinner = true;
                        });

                        await Future.delayed(const Duration(seconds: 2));

                        final FirebaseAuth auth = FirebaseAuth.instance;

                        String UserID = FirebaseAuth.instance.currentUser!.uid;

                        upload() async {
                          final User user = auth.currentUser!;
                          final uemail = user.email;

                          DatabaseReference ref =
                              FirebaseDatabase.instance.ref("Users/$UserID");

                          await ref.set({
                            "email": uemail,
                            "name": name,
                            "location": location,
                            "education": education,
                            "experience": experience,
                            "subject": subject,
                            "about": about
                          });
                        }

                        upload();

                        Navigator.pushNamed(context, 'home_screen');

                        setState(() {
                          showSpinner = false;
                        });
                      }
                    : () => null,
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
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'home_screen');
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color.fromARGB(0, 168, 175, 255),
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width / 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                child: const Text('Skip',
                    style: TextStyle(
                        color: Color.fromARGB(255, 168, 175, 255),
                        fontFamily: 'Cairo-Regular',
                        fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }
}


//Confirm Password
//name
