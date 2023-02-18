import 'package:edu_point/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void logout() async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (route) => false);
  }

  String userID = FirebaseAuth.instance.currentUser!.uid;

  String name = '';
  String location = '';
  String education = '';
  String experience = '';
  String subject = '';
  String about = '';
  String ProfileURL =
      'https://firebasestorage.googleapis.com/v0/b/edupoint-8e35b.appspot.com/o/files%2FProfile%2F0c3b3adb1a7530892e55ef36d3be6cb8.jpg?alt=media&token=79c4d9d4-0799-4740-b005-4642c626a467';

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Users/$userID').get();
    if (snapshot.exists) {
      setState(() {
        name = snapshot.child('name').value.toString();
        location = snapshot.child('location').value.toString();
        education = snapshot.child('education').value.toString();
        experience = snapshot.child('experience').value.toString();
        subject = snapshot.child('subject').value.toString();
        about = snapshot.child('about').value.toString();
        ProfileURL = snapshot.child('profile_picture').value.toString();
      });
    }
  }

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
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.width / 5,
                      child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 5,
                          backgroundImage: NetworkImage(ProfileURL))),
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
