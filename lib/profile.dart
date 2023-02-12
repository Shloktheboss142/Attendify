import 'package:edu_point/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void logout() async {
    // setState(() {
    //   showSpinner = true;
    // });

    // await Future.delayed(Duration(seconds: 2));

    // setState(() {
    //   showSpinner = false;
    // });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  String UserID = FirebaseAuth.instance.currentUser!.uid;

  String? name;
  String? location;
  String? education;
  String? experience;
  String? subject;
  String? about;

  String UserIdentifier = 'Users/';

  Future getData() async {
    // FirebaseDatabase database = FirebaseDatabase.instance;
    // UserIdentifier = UserIdentifier + UserID;
    // print(UserIdentifier);
    // DatabaseReference ref = FirebaseDatabase.instance.ref(UserIdentifier);
    // print(ref.once());

// Get the data once
    // DatabaseEvent event = await ref.once();

// Print the data of the snapshot
    // print(event.snapshot.value); // { "name": "John" }

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!['name'];
          location = snapshot.data()!['location'];
          education = snapshot.data()!['education'];
          experience = snapshot.data()!['experience'];
          subject = snapshot.data()!['subject'];
          about = snapshot.data()!['about'];
        });
      }
    });
  }

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(40, 43, 78, 1),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Profile",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontFamily: 'Cairo-Regular',
                    fontWeight: FontWeight.w400)),
            const Text("", style: TextStyle(fontSize: 10)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(100, 98, 107, 182),
              ),
              width: MediaQuery.of(context).size.width - 25,
              height: MediaQuery.of(context).size.height - 270,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: MediaQuery.of(context).size.width / 2,
                  ),
                  Text(name.toString(),
                      style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontFamily: 'Cairo-Regular',
                          fontWeight: FontWeight.w400)),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "Location: ",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: location.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Cairo-Regular',
                                    fontWeight: FontWeight.w400))
                          ])),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "Education: ",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: education.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Cairo-Regular',
                                    fontWeight: FontWeight.w400))
                          ])),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "Experience: ",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: experience.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Cairo-Regular',
                                    fontWeight: FontWeight.w400))
                          ])),
                  const Text("", style: TextStyle(fontSize: 10)),
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "Subject: ",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Cairo-Regular',
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                                text: subject.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Cairo-Regular',
                                    fontWeight: FontWeight.w400))
                          ])),
                  const Text("", style: TextStyle(fontSize: 1)),
                  const Text(
                    "About",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Cairo-Regular',
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    about.toString(),
                    style: const TextStyle(
                        overflow: TextOverflow.clip,
                        fontSize: 16,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Cairo-Regular',
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  const Text("", style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
            const Text("", style: TextStyle(fontSize: 10)),
            ElevatedButton(
              onPressed: () {
                logout();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 25, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: const Text('Logout',
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
                  backgroundColor: const Color.fromARGB(255, 168, 175, 255),
                  fixedSize: Size(MediaQuery.of(context).size.width - 25, 50),
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
    );
  }
}
