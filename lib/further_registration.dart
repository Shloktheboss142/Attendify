import 'package:edu_point/profile_pic.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

const kTextFieldDecoration = InputDecoration(
  floatingLabelStyle: TextStyle(color: Color.fromARGB(255, 168, 175, 255)),
  labelStyle: TextStyle(color: Color.fromARGB(150, 255, 255, 255)),
  hintStyle: TextStyle(color: Colors.white),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: UnderlineInputBorder(),
  // OutlineInputBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
  // ),
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 168, 175, 255))),
  // OutlineInputBorder(
  //   borderSide: BorderSide(color: Color.fromARGB(255, 168, 175, 255)),
  //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
  // ),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 168, 175, 255))),
  // OutlineInputBorder(
  //   borderSide: BorderSide(color: Color.fromARGB(255, 168, 175, 255)),
  //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
  // )
);

class FurtherRegistration extends StatefulWidget {
  const FurtherRegistration({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      backgroundColor: const Color.fromARGB(255, 40, 43, 78),
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
                  textAlign: TextAlign.justify,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.person,
                          color: Color.fromARGB(255, 168, 175, 255)),
                      labelText: 'Name *',
                      hintText: 'What should we call you?',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              // const SizedBox(
              //   height: 8.0,
              // ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: false,
                  textAlign: TextAlign.justify,
                  onChanged: (value) {
                    location = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.location_on,
                          color: Color.fromARGB(255, 168, 175, 255)),
                      labelText: 'Location',
                      hintText: 'Where are you situated?',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              // const SizedBox(
              //   height: 8.0,
              // ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: false,
                  textAlign: TextAlign.justify,
                  onChanged: (value) {
                    education = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.school,
                          color: Color.fromARGB(255, 168, 175, 255)),
                      labelText: 'Education',
                      hintText: 'Educational background',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              // const SizedBox(
              //   height: 8.0,
              // ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: false,
                  textAlign: TextAlign.justify,
                  onChanged: (value) {
                    experience = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.work,
                          color: Color.fromARGB(255, 168, 175, 255)),
                      labelText: 'Experience',
                      hintText: 'Years of experience',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              // const SizedBox(
              //   height: 8.0,
              // ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: false,
                  textAlign: TextAlign.justify,
                  onChanged: (value) {
                    subject = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.subject,
                          color: Color.fromARGB(255, 168, 175, 255)),
                      labelText: 'Subjects',
                      hintText: 'What subject(s) do you teach?',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              // const SizedBox(
              //   height: 8.0,
              // ),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: false,
                  textAlign: TextAlign.justify,
                  onChanged: (value) {
                    about = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.question_mark,
                          color: Color.fromARGB(255, 168, 175, 255)),
                      labelText: 'About',
                      hintText: 'Give some info about yourself',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              const SizedBox(
                height: 8,
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      '* Required',
                      style:
                          TextStyle(color: Color.fromARGB(150, 255, 255, 255)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32.0,
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

                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfilePicPicker()));

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePicPicker()));
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
