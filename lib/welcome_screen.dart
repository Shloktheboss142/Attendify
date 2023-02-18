import 'package:edu_point/login_screen.dart';
import 'package:edu_point/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(40, 43, 78, 1),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(0, 98, 107, 182),
                  ),
                  width: MediaQuery.of(context).size.width - 25,
                  height: MediaQuery.of(context).size.height - 125,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(0, 98, 107, 182),
                            ),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Welcome to",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Cairo-Regular')),
                                  const Text('',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Staatliches',
                                          fontSize: 6)),
                                  RichText(
                                      text: const TextSpan(
                                          text: 'A',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 250, 158, 159),
                                              fontSize: 40,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Montserrat'),
                                          children: [
                                        TextSpan(
                                            text: 'T',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 236, 155, 166),
                                                fontSize: 40,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Montserrat')),
                                        TextSpan(
                                            text: 'T',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 223, 153, 174),
                                                fontSize: 40,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Montserrat')),
                                        TextSpan(
                                            text: 'E',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 208, 150, 181),
                                                fontSize: 40,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Montserrat')),
                                        TextSpan(
                                            text: 'N',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 195, 148, 188),
                                                fontSize: 40,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Montserrat')),
                                        TextSpan(
                                            text: 'D',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 181, 145, 195),
                                                fontSize: 40,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Montserrat')),
                                        TextSpan(
                                            text: 'I',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 167, 142, 203),
                                                fontSize: 40,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Montserrat')),
                                        TextSpan(
                                            text: 'F',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 153, 140, 210),
                                                fontSize: 40,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Montserrat')),
                                        TextSpan(
                                            text: 'Y',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 139, 137, 217),
                                                fontSize: 40,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Montserrat')),
                                      ])),
                                ])),
                        Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(0, 98, 107, 182),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: const Color.fromARGB(
                                              255, 168, 175, 255),
                                          minimumSize:
                                              const Size(double.infinity, 10),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0))),
                                      child: const Text('Login',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Staatliches',
                                              fontSize: 35))),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegistrationScreen()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: const Color.fromARGB(
                                              255, 168, 175, 255),
                                          minimumSize:
                                              const Size(double.infinity, 10),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0))),
                                      child: const Text('Register',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Staatliches',
                                              fontSize: 35))),
                                ])),
                      ]),
                ),
              ]),
        ));
  }
}
