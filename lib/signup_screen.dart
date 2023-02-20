import 'package:edu_point/further_registration.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

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
  String name = '';
  String emailText = "Enter your email";
  var emailColor = Colors.white;
  String passwordText = "Create a password";
  var passwordColor = Colors.white;
  bool showSpinner = false;
  final TextEditingController controller = TextEditingController();
  bool submit = false;
  ValueNotifier<bool> _passwordVisible =
      ValueNotifier<bool>(true); //to track password visibility

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
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
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
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: emailText,
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)))),
              const SizedBox(
                height: 8.0,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _passwordVisible,
                builder: (context, value, child) {
                  return TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      obscureText: value,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: passwordText,
                        hintStyle: TextStyle(color: passwordColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            value ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _passwordVisible.value = !_passwordVisible.value;
                          },
                        ),
                      ));
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              FlutterPwValidator(
                controller: controller,
                minLength: 6,
                uppercaseCharCount: 1,
                numericCharCount: 1,
                specialCharCount: 1,
                width: 380,
                height: 120,
                onSuccess: () {
                  submit = true;
                },
                onFail: () {
                  submit = false;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                onPressed: submit
                    ? () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FurtherRegistration()));
                          } else {
                            RegistrationScreen;
                          }
                        } catch (e) {
                          if (e.toString() ==
                              "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
                            emailText =
                                ("A user with that email aready exists");
                            passwordText = 'Create a password';
                            passwordColor = Colors.white;
                            emailColor = Colors.red;
                          } else if (e.toString() ==
                              "[firebase_auth/invalid-email] The email address is badly formatted.") {
                            emailText = ("Badly formatted email");
                            passwordText = 'Create a password';
                            passwordColor = Colors.white;
                            emailColor = Colors.red;
                          } else if (e.toString() ==
                              "[firebase_auth/weak-password] Password should be at least 6 characters") {
                            passwordText =
                                'Password must be at least 6 characters';
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
                      }
                    : () => null,
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width / 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                child: const Text('Continue',
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
