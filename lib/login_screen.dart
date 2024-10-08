import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';

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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  String passwordText = 'Enter your password';
  var passwordColor = const Color.fromARGB(150, 255, 255, 255);
  String emailText = "Enter your email";
  var emailColor = const Color.fromARGB(150, 255, 255, 255);
  String email = '';
  String password = '';
  bool showSpinner = false;
  ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _isObscure.dispose();
    super.dispose();
  }

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
            children: <Widget>[
              TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.justify,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: const Icon(Icons.mail,
                          color: Color.fromARGB(255, 168, 175, 255)),
                      labelText: 'Email',
                      hintText: emailText,
                      hintStyle: TextStyle(color: emailColor))),
              // const SizedBox(
              //   height: 8.0,
              // ),
              ValueListenableBuilder<bool>(
                valueListenable: _isObscure,
                builder: (context, value, child) {
                  return TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      obscureText: value,
                      textAlign: TextAlign.justify,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        prefixIcon: const Icon(Icons.lock,
                            color: Color.fromARGB(255, 168, 175, 255)),
                        labelText: 'Password',
                        hintText: passwordText,
                        hintStyle: TextStyle(color: passwordColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            value ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _isObscure.value = !_isObscure.value;
                          },
                        ),
                      ));
                },
              ),
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
                      await Future.delayed(const Duration(seconds: 2));
                      Navigator.pushNamed(context, 'home_screen');
                    }
                  } catch (e) {
                    if (e.toString() ==
                        "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
                      emailText = ("No user found for that email");
                      passwordText = 'Enter your password';
                      passwordColor = const Color.fromARGB(150, 255, 255, 255);
                      emailColor = Colors.red;
                    } else if (e.toString() ==
                        "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
                      passwordText = 'Password incorrect, please try again';
                      emailText = ("Enter your email");
                      emailColor = const Color.fromARGB(150, 255, 255, 255);
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
