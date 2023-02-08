import 'package:edu_point/login_screen.dart';
import 'package:edu_point/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
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
                    color: Color.fromARGB(0, 98, 107, 182),
                  ),
                  width: MediaQuery.of(context).size.width - 25,
                  height: MediaQuery.of(context).size.height - 750,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Welcome to",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Cairo-Regular')),
                        RichText(
                            text: const TextSpan(
                                text: "Edu",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Cairo-Regular'),
                                children: [
                              TextSpan(
                                  text: ' Point',
                                  style: TextStyle(
                                      color: Color.fromRGBO(130, 133, 168, 1),
                                      fontSize: 40,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Cairo-Regular'))
                            ])),
                        const Text("", style: TextStyle(fontSize: 15)),
                      ]),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color.fromARGB(255, 168, 175, 255),
                        minimumSize: const Size(double.infinity, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    child: const Text('Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Staatliches',
                            fontSize: 35))),
                const Text("", style: TextStyle(fontSize: 10)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color.fromARGB(255, 168, 175, 255),
                        minimumSize: const Size(double.infinity, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    child: const Text('Register',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Staatliches',
                            fontSize: 35))),
              ]),
        ));
  }
}
